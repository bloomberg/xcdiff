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

final class TargetsHelper {
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

    func headers(from target: PBXTarget) throws -> [HeaderDescriptor] {
        guard let headersBuildPhase = target.headersBuildPhase() else {
            return []
        }
        let buildFiles = headersBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            HeaderDescriptor(path: try path(from: $0) ?? "",
                             attributes: $0.attributes())
        }
    }

    func sources(from target: PBXTarget) throws -> [SourceDescriptor] {
        guard let sourcesBuildPhase = try target.sourcesBuildPhase() else {
            return []
        }
        let buildFiles = sourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            SourceDescriptor(path: try path(from: $0) ?? "",
                             flags: $0.compilerFlags())
        }
    }

    func resources(from target: PBXTarget) throws -> [String] {
        guard let resourcesBuildPhase = try target.resourcesBuildPhase() else {
            return []
        }
        let buildFiles = resourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.compactMap {
            try path(from: $0)
        }
    }

    private func path(from buildFile: PBXBuildFile) throws -> String? {
        // TODO: Maybe pass it via init?
        let sourceRoot = Path("/")
        guard let path = try buildFile.file?.fullPath(sourceRoot: sourceRoot) else {
            return nil
        }
        return String(path.string)
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
