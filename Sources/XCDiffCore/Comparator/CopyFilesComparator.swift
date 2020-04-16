//
// Copyright 2020 Bloomberg Finance L.P.
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

final class CopyFilesComparator: Comparator {
    let tag = "copy_files"
    private let targetsHelper = TargetsHelper()
    private let pathHelper = PathHelper()

    func compare(_ first: ProjectDescriptor, _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return try targetsHelper
            .commonTargets(first, second, parameters: parameters)
            .flatMap { try compare($0, $1, firstSourceRoot: first.sourceRoot, secondSourceRoot: second.sourceRoot) }
    }

    // MARK: - Private

    private func compare(_ first: PBXTarget,
                         _ second: PBXTarget,
                         firstSourceRoot: Path,
                         secondSourceRoot: Path) throws -> [CompareResult] {
        let context = ["\"\(first.name)\" target"]
        let firstDescriptors = try descriptors(from: first, sourceRoot: firstSourceRoot)
        let secondDescriptors = try descriptors(from: second, sourceRoot: secondSourceRoot)
        let firstGrouped = Dictionary(grouping: firstDescriptors, by: { $0.name })
        let secondGrouped = Dictionary(grouping: secondDescriptors, by: { $0.name })
        let commonKeys = Set(firstGrouped.keys).intersection(secondGrouped.keys)
        let compareResult = try commonKeys.flatMap { try compare(firstGrouped[$0]!,
                                                                 secondGrouped[$0]!,
                                                                 context: context + [$0]) }
        guard !compareResult.isEmpty else {
            return [result(context: context)]
        }
        return compareResult
    }

    private func compare(_ first: [CopyFilesBuildPhaseDescriptor],
                         _ second: [CopyFilesBuildPhaseDescriptor],
                         context: [String]) throws -> [CompareResult] {
        let count = max(first.count, second.count)
        return try (0 ..< count).map { try compare(first[safe: $0], second[safe: $0], context: context) }
    }

    private func compare(_ first: CopyFilesBuildPhaseDescriptor?,
                         _ second: CopyFilesBuildPhaseDescriptor?,
                         context: [String]) throws -> CompareResult {
        guard let first = first else {
            return result(context: context,
                          description: "The build phase does not exist in the first project",
                          onlyInSecond: ["Duplicated build phase name"])
        }
        guard let second = second else {
            return result(context: context,
                          description: "The build phase does not exist in the second project",
                          onlyInFirst: ["Duplicated build phase name"])
        }
        let firstFiles = Dictionary(grouping: first.files, by: { $0.path })
        let secondFiles = Dictionary(grouping: second.files, by: { $0.path })
        let firstKeys = firstFiles.keys.map { String($0) }.toSet()
        let secondKeys = secondFiles.keys.map { String($0) }.toSet()
        let onlyInFirst = firstKeys.subtractingAndSorted(secondKeys)
        let onlyInSecond = secondKeys.subtractingAndSorted(firstKeys)
        let properties = first.differentValues(second: second)
        let files = try compareFiles(first, second)
        return result(context: context,
                      onlyInFirst: onlyInFirst,
                      onlyInSecond: onlyInSecond,
                      differentValues: properties + files)
    }

    private func compareFiles(_ first: CopyFilesBuildPhaseDescriptor,
                              _ second: CopyFilesBuildPhaseDescriptor) throws -> [CompareResult.DifferentValues] {
        let firstFiles = Dictionary(grouping: first.files, by: { $0.path })
        let secondFiles = Dictionary(grouping: second.files, by: { $0.path })
        let commonPaths = Set(firstFiles.keys).intersection(secondFiles.keys).map { String($0) }
        return try commonPaths.flatMap { path -> [CompareResult.DifferentValues] in
            let firstArray = firstFiles[path]!
            let secondArray = secondFiles[path]!
            guard firstArray.count == 1 else {
                throw ComparatorError.generic(
                    "\(first.name) Build Phase in first contains \(firstArray.count) references " +
                        "to the same file (path = \(path))")
            }
            guard secondArray.count == 1 else {
                throw ComparatorError.generic(
                    "\(second.name) Build Phase in second contains \(secondArray.count) references " +
                        "to the same file (path = \(path))")
            }
            let firstPath = firstArray[0]
            let secondPath = secondArray[0]
            if firstPath != secondPath {
                return [.init(context: path,
                              first: firstPath.properties(compareTo: secondPath),
                              second: secondPath.properties(compareTo: firstPath))]
            }
            return []
        }
    }

    private func descriptors(from target: PBXTarget, sourceRoot: Path) throws -> [CopyFilesBuildPhaseDescriptor] {
        // looks like XcodeProj PBXBuildPhase.name() never returns nil
        return try target.copyFilesBuildPhases().map {
            CopyFilesBuildPhaseDescriptor(
                name: $0.name()!,
                inputFileListPaths: $0.inputFileListPaths,
                outputFileListPaths: $0.outputFileListPaths,
                runOnlyForDeploymentPostprocessing: $0.runOnlyForDeploymentPostprocessing,
                dstPath: $0.dstPath,
                dstSubfolderSpec: $0.dstSubfolderSpec,
                files: try descriptors(from: $0.files ?? [], sourceRoot: sourceRoot)
            )
        }
    }

    private func descriptors(from files: [PBXBuildFile], sourceRoot: Path) throws -> [FileDescriptor] {
        return try files
            .compactMap {
                guard let path = try pathHelper.fullPath(from: $0.file, sourceRoot: sourceRoot) ?? $0.file?.path else {
                    return nil
                }
                let attributes = $0.settings?["ATTRIBUTES"] as? [String] ?? []
                return FileDescriptor(path: path, platformFilter: $0.platformFilter, attributes: attributes)
            }
    }
}

private struct CopyFilesBuildPhaseDescriptor: Equatable {
    let name: String
    let inputFileListPaths: [String]?
    let outputFileListPaths: [String]?
    let runOnlyForDeploymentPostprocessing: Bool
    let dstPath: String?
    let dstSubfolderSpec: PBXCopyFilesBuildPhase.SubFolder?
    let files: [FileDescriptor]

    func differentValues(second: CopyFilesBuildPhaseDescriptor) -> [CompareResult.DifferentValues] {
        var result = [CompareResult.DifferentValues]()
        if runOnlyForDeploymentPostprocessing != second.runOnlyForDeploymentPostprocessing {
            result.append(.init(context: "runOnlyForDeploymentPostprocessing",
                                first: "\(runOnlyForDeploymentPostprocessing)",
                                second: "\(second.runOnlyForDeploymentPostprocessing)"))
        }
        if inputFileListPaths.valueOrEmpty != second.inputFileListPaths.valueOrEmpty {
            result.append(.init(context: "inputFileListPaths",
                                first: "\(describe(inputFileListPaths))",
                                second: "\(describe(second.inputFileListPaths))"))
        }
        if outputFileListPaths.valueOrEmpty != second.outputFileListPaths.valueOrEmpty {
            result.append(.init(context: "outputFileListPaths",
                                first: "\(describe(outputFileListPaths))",
                                second: "\(describe(second.outputFileListPaths))"))
        }
        if dstPath != second.dstPath {
            result.append(.init(context: "dstPath",
                                first: "\(describe(dstPath))",
                                second: "\(describe(second.dstPath))"))
        }
        if dstSubfolderSpec != second.dstSubfolderSpec {
            result.append(.init(context: "dstSubfolderSpec",
                                first: "\(describe(dstSubfolderSpec))",
                                second: "\(describe(second.dstSubfolderSpec))"))
        }
        return result
    }
}

private struct FileDescriptor: Equatable {
    let path: String
    let platformFilter: String?
    let attributes: [String]

    func properties(compareTo second: FileDescriptor) -> String {
        var result = [String]()
        if platformFilter != second.platformFilter {
            result.append("platformFilter = \(describe(platformFilter))")
        }
        if attributes != second.attributes {
            result.append("attributes = \(attributes.toSet().subtractingAndSorted(second.attributes.toSet()))")
        }
        return result.joined(separator: ", ")
    }
}
