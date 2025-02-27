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

struct SourceDescriptor: Hashable, DiffComparable {
    var diffKey: String {
        path
    }

    let path: String
    let flags: String?
    let platformFilters: [String]?
}

struct HeaderDescriptor: Hashable, DiffComparable {
    var diffKey: String {
        path
    }

    let path: String
    let attributes: String?
    let platformFilters: [String]?
}

struct FileSystemSynchronizedGroupDescriptor: Hashable, DiffComparable {
    var diffKey: String {
        key ?? ""
    }

    var key: String? {
        name ?? path
    }

    let name: String?
    let path: String?
}

struct LinkedDependencyDescriptor: Hashable, DiffComparable {
    var diffKey: String {
        key ?? ""
    }

    var key: String? {
        name ?? path
    }

    let name: String?
    let path: String?
    let package: SwiftPackageDescriptor?
    let type: DependencyDescriptorType
    let platformFilters: [String]?
}

enum DependencyDescriptorType: String {
    case required
    case optional
}

enum AttributeValue: Equatable, CustomStringConvertible {
    case dictionary([String: AttributeValue])
    case string(String)

    var description: String {
        switch self {
        case let .string(string):
            return "\(string)"
        case let .dictionary(dictionary):
            return string(from: dictionary)
        }
    }

    private func string(from dictionary: [String: AttributeValue]) -> String {
        let value = dictionary
            .sorted { $0.key < $1.key }
            .map { "\"\($0.key)\": \(string(from: $0.value))" }
            .joined(separator: ", ")
        return "[\(value)]"
    }

    private func string(from value: AttributeValue) -> String {
        switch value {
        case let .dictionary(dictionary):
            return string(from: dictionary)
        case let .string(string):
            return "\"\(string)\""
        }
    }
}

final class TargetsHelper {
    private let pathHelper = PathHelper()

    func targets(from projectDescription: ProjectDescriptor) -> Set<String> {
        return native(from: projectDescription).union(aggregate(from: projectDescription))
    }

    func native(from projectDescriptor: ProjectDescriptor) -> Set<String> {
        return Set(projectDescriptor.pbxproj.nativeTargets.map { $0.name })
    }

    func aggregate(from projectDescriptor: ProjectDescriptor) -> Set<String> {
        return Set(projectDescriptor.pbxproj.aggregateTargets.map { $0.name })
    }

    /// Find common targets
    func commonTargets(_ first: ProjectDescriptor, _ second: ProjectDescriptor,
                       parameters: ComparatorParameters) throws -> [TargetPair] {
        try targets(from: first)
            .intersection(targets(from: second))
            .validateTargetsOption(parameters)
        return targets(from: first)
            .intersection(targets(from: second))
            .filter(by: parameters.targets)
            .sorted()
            .map { (first: first.pbxproj.targets(named: $0)[0],
                    second: second.pbxproj.targets(named: $0)[0]) }
    }

    func headers(from target: PBXTarget, sourceRoot: Path) throws -> [HeaderDescriptor] {
        guard let headersBuildPhase = target.headersBuildPhase() else {
            return []
        }
        let buildFiles = headersBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            HeaderDescriptor(
                path: try path(from: $0.file, sourceRoot: sourceRoot) ?? "",
                attributes: $0.attributes(),
                platformFilters: $0.combinedPlatformFilters()
            )
        }
    }

    /// Find common configurations
    func commonConfigurations(_ first: ProjectDescriptor,
                              _ second: ProjectDescriptor) -> [String] {
        let firstConfigurations = configurations(from: first)
        let secondConfigurations = configurations(from: second)
        return firstConfigurations.intersectionSorted(secondConfigurations)
    }

    func sources(from target: PBXTarget, sourceRoot: Path) throws -> [SourceDescriptor] {
        guard let sourcesBuildPhase = try target.sourcesBuildPhase() else {
            return []
        }
        let buildFiles = sourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.map {
            SourceDescriptor(
                path: try path(from: $0.file, sourceRoot: sourceRoot) ?? "",
                flags: $0.compilerFlags(),
                platformFilters: $0.combinedPlatformFilters()
            )
        }
    }

    func resources(
        from target: PBXTarget,
        sourceRoot: Path
    ) throws -> [BuildFileDescriptor] {
        guard let resourcesBuildPhase = try target.resourcesBuildPhase() else {
            return []
        }
        let buildFiles = resourcesBuildPhase.files?.compactMap { $0 } ?? []

        return try buildFiles.compactMap {
            guard let path = try path(from: $0.file, sourceRoot: sourceRoot) else {
                return nil
            }
            return BuildFileDescriptor(
                name: path,
                platformFilters: $0.combinedPlatformFilters(),
                attributes: []
            )
        }
    }

    func fileSystemSynchronizedGroups(
        from target: PBXTarget,
        sourceRoot: Path
    ) throws -> [FileSystemSynchronizedGroupDescriptor] {
        guard let fileSystemSynchronizedGroups = target.fileSystemSynchronizedGroups else {
            return []
        }

        return try fileSystemSynchronizedGroups.map { rootGroup in
            FileSystemSynchronizedGroupDescriptor(
                name: rootGroup.name,
                path: try path(from: rootGroup, sourceRoot: sourceRoot) ?? rootGroup.path
            )
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

    func linkedDependencies(from target: PBXTarget) throws -> [LinkedDependencyDescriptor] {
        guard let linkedDependencies = target.buildPhases.compactMap({ $0 as? PBXFrameworksBuildPhase }).first,
              let dependencyFiles = linkedDependencies.files else {
            return []
        }
        return dependencyFiles.compactMap {
            if $0.file?.name != nil || $0.file?.path != nil {
                return LinkedDependencyDescriptor(
                    name: $0.file?.name,
                    path: $0.file?.path,
                    package: nil,
                    type: $0.settings == nil ? .required : .optional,
                    platformFilters: $0.combinedPlatformFilters()
                )
            } else if let product = $0.product {
                return LinkedDependencyDescriptor(
                    name: product.productName,
                    path: nil,
                    package: product.package.flatMap(swiftPackageDescriptor),
                    type: $0.settings == nil ? .required : .optional,
                    platformFilters: $0.combinedPlatformFilters()
                )
            }
            return nil
        }
    }

    func attributes(from pbxproj: PBXProj) throws -> [String: AttributeValue] {
        guard let rootProject = try pbxproj.rootProject() else {
            return [:]
        }

        return rootProject.attributes.mapValues(attributeValue)
    }

    func targetAttributes(pbxproj: PBXProj, target: PBXTarget) throws -> [String: AttributeValue] {
        guard let rootProject = try pbxproj.rootProject(),
              let attributes = rootProject.targetAttributes[target] else {
            return [:]
        }

        let targetsLookup: [String: PBXTarget] = Dictionary(
            rootProject.targets.map {
                ($0.uuid, $0)
            },
            uniquingKeysWith: { $1 }
        )

        return attributes.mapValues { value in
            // Some attributes like `TestTargetID` store references to other targets
            // as such those need to be resolved to allow semantic comparisons
            if let target = targetsLookup["\(value)"] {
                return .string(target.name)
            }
            return attributeValue(value)
        }
    }

    func swiftPackages(in projectDescriptor: ProjectDescriptor) throws -> [SwiftPackageDescriptor] {
        guard let rootProject = try projectDescriptor.pbxproj.rootProject() else {
            return []
        }

        return rootProject.packages.map(swiftPackageDescriptor)
    }

    private func swiftPackageDescriptor(from package: XCRemoteSwiftPackageReference) -> SwiftPackageDescriptor {
        SwiftPackageDescriptor(
            name: package.name ?? "nil",
            url: package.repositoryURL ?? "nil",
            version: package.versionRequirement?.description ?? "nil"
        )
    }

    // MARK: - Private

    private func path(from fileElement: PBXFileElement?, sourceRoot: Path) throws -> String? {
        return try pathHelper.fullPath(from: fileElement, sourceRoot: sourceRoot) ?? fileElement?.path
    }

    private func attributeValue(_ value: Any) -> AttributeValue {
        if let pbxTarget = value as? PBXTarget {
            return .string(pbxTarget.name)
        }
        if let dictionary = value as? [String: Any] {
            return .dictionary(dictionary.mapValues(attributeValue))
        }
        return .string(String(describing: value))
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
        return String(describing: anyAttributes)
    }
}

extension PBXBuildFile {
    func combinedPlatformFilters() -> [String]? {
        guard platformFilter != nil || platformFilters != nil else {
            return nil
        }
        var filters: [String] = []
        if let platformFilter {
            filters.append(platformFilter)
        }

        if let platformFilters {
            filters.append(contentsOf: platformFilters)
        }

        return filters
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

// MARK: - Collection Extensions

extension Set where Set.Element == String {
    func validateTargetsOption(_ parameters: ComparatorParameters) throws {
        try validate(type: "target", option: parameters.targets)
    }

    private func validate(type: String, option: ComparatorParameters.Option<String>) throws {
        guard let allOptions = option.values() else {
            return
        }
        let unknown = Set(allOptions).subtracting(self)
        guard unknown.isEmpty else {
            throw ComparatorError.cannotFind(type: type, elements: unknown.sorted())
        }
    }
}

extension Array where Array.Element == TargetPair {
    func filter(by option: ComparatorParameters.Option<String>) -> [TargetPair] {
        return filter { option.contains($0.first.name) && option.contains($0.second.name) }
    }
}
