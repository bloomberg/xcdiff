//
// Copyright 2019 Bloomberg Finance L.P.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import PathKit
import XcodeProj

typealias TargetPair = (first: PBXTarget, second: PBXTarget)

struct SourceDescriptor: Equatable, Hashable {
    let path: String
    let flags: String?
}

struct HeaderDescriptor: Equatable, Hashable {
    let path: String
    let attributes: String?
}

struct DependencyDescriptor: Equatable, Hashable {
    let name: String?
    let path: String?
    let type: DependencyDescriptorType
}

enum DependencyDescriptorType: String {
    case required
    case optional
}

final class TargetsHelper {
    private let pathHelper = PathHelper()

    func native(from projectDescriptor: ProjectDescriptor) -> Set<String> {
        return Set(projectDescriptor.pbxproj.nativeTargets.map { $0.name })
    }

    func aggregate(from projectDescriptor: ProjectDescriptor) -> Set<String> {
        return Set(projectDescriptor.pbxproj.aggregateTargets.map { $0.name })
    }

    /// Find common targets
    func commonTargets(_ first: ProjectDescriptor,
                       _ second: ProjectDescriptor) throws -> [TargetPair] {
        let firstTargetNames = native(from: first).union(aggregate(from: first))
        let secondTargetNames = native(from: second).union(aggregate(from: second))
        let commonTargetNames = firstTargetNames.union(secondTargetNames).sorted()
        return commonTargetNames.compactMap { name -> TargetPair? in
            let firstTargets = first.pbxproj.targets(named: name)
            let secondTargets = second.pbxproj.targets(named: name)
            guard let firstTarget = firstTargets.first else {
                return nil
            }
            guard let secondTarget = secondTargets.first else {
                return nil
            }
            return (first: firstTarget, second: secondTarget)
        }
    }

    func headers(from target: PBXTarget, sourceRoot: Path) throws -> [HeaderDescriptor] {
        guard let headersBuildPhase = target.headersBuildPhase() else {
            return []
        }
        let buildFiles = headersBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            HeaderDescriptor(path: try path(from: $0.file, sourceRoot: sourceRoot) ?? "",
                             attributes: $0.attributes())
        }
    }

    /// Find common configurations
    func commonConfigurations(_ first: ProjectDescriptor,
                              _ second: ProjectDescriptor) -> [String] {
        let firstConfigurations = Set(configurations(from: first))
        let secondConfigurations = Set(configurations(from: second))
        return firstConfigurations.intersectionSorted(secondConfigurations)
    }

    func sources(from target: PBXTarget, sourceRoot: Path) throws -> [SourceDescriptor] {
        guard let sourcesBuildPhase = try target.sourcesBuildPhase() else {
            return []
        }
        let buildFiles = sourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            SourceDescriptor(path: try path(from: $0.file, sourceRoot: sourceRoot) ?? "",
                             flags: $0.compilerFlags())
        }
    }

    func resources(from target: PBXTarget, sourceRoot: Path) throws -> [String] {
        guard let resourcesBuildPhase = try target.resourcesBuildPhase() else {
            return []
        }
        let buildFiles = resourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.compactMap {
            try path(from: $0.file, sourceRoot: sourceRoot)
        }
    }

    func fileReferences(from proj: PBXProj, sourceRoot: Path) throws -> Set<String> {
        return try proj.fileReferences
            .map { try path(from: $0, sourceRoot: sourceRoot) ?? $0.path }
            .compactMap { $0 }
            .toSet()
    }

    /// Find project configurations
    func configurations(from projectDescriptor: ProjectDescriptor) -> Set<String> {
        return Set(projectDescriptor.pbxproj.configurationLists
            .flatMap { $0.buildConfigurations }
            .map { $0.name })
    }

    func dependencies(from target: PBXTarget) throws -> [DependencyDescriptor] {
        guard let dependencies = target.buildPhases.compactMap({ $0 as? PBXFrameworksBuildPhase }).first,
            let dependencyFiles = dependencies.files else {
            return []
        }
        return dependencyFiles.compactMap {
            if $0.file?.name != nil || $0.file?.path != nil {
                return DependencyDescriptor(name: $0.file?.name,
                                            path: $0.file?.path,
                                            type: $0.settings == nil ? .required : .optional)
            }
            return nil
        }
    }

    private func path(from fileElement: PBXFileElement?, sourceRoot: Path) throws -> String? {
        return try pathHelper.fullPath(from: fileElement, sourceRoot: sourceRoot)
    }
}

// MARK: - XcodeProj Extensions

private extension PBXBuildFile {
    func compilerFlags() -> String? {
        guard let flags = settings?["COMPILER_FLAGS"] else {
            return nil
        }
        if let flagsString = flags as? String {
            return flagsString
        }
        if let flagsArray = flags as? [String] {
            return flagsArray.joined(separator: ", ")
        }

        return nil
    }

    func attributes() -> String? {
        guard let anyAttributes = settings?["ATTRIBUTES"] else {
            return nil
        }
        if let attributes = anyAttributes as? [String] {
            return attributes.joined(separator: ", ")
        }
        if let attributes = anyAttributes as? String {
            return attributes
        }
        return nil
    }
}

extension Array where Array.Element == TargetPair {
    func filter(by option: ComparatorParameters.Option<String>) throws -> [TargetPair] {
        guard let allOptions = option.values() else {
            return self
        }
        let names = map { $0.first.name }
        let unknownTargets = Set(allOptions).subtracting(names)
        guard unknownTargets.isEmpty else {
            throw ComparatorError.cannotFind(type: "target", elements: unknownTargets.sorted())
        }
        return filter { option.contains($0.first.name) }
    }
}

private extension PBXTarget {
    func headersBuildPhase() -> PBXHeadersBuildPhase? {
        return buildPhases
            .filter { $0.buildPhase == .headers }
            .compactMap { $0 as? PBXHeadersBuildPhase }
            .first
    }
}
