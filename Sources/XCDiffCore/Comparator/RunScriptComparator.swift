//
// Copyright 2022 Bloomberg Finance L.P.
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
import XcodeProj

final class RunScriptComparator: Comparator {
    let tag = "run_scripts"
    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return try targetsHelper
            .commonTargets(first, second, parameters: parameters)
            .flatMap { try compare($0, $1) }
    }

    // MARK: - Private

    private func compare(_ first: PBXTarget,
                         _ second: PBXTarget) throws -> [CompareResult] {
        let context = ["\"\(first.name)\" target"]
        let firstDescriptors = descriptors(from: first)
        let secondDescriptors = descriptors(from: second)
        let firstGrouped = Dictionary(grouping: firstDescriptors, by: { $0.name })
        let secondGrouped = Dictionary(grouping: secondDescriptors, by: { $0.name })
        let commonKeys = Set(firstGrouped.keys).intersection(secondGrouped.keys)
        let compareResult = try commonKeys.sorted().flatMap {
            try compare(firstGrouped[$0]!,
                        secondGrouped[$0]!,
                        context: context + ["\"\($0)\" build phase"])
        }
        guard !compareResult.isEmpty else {
            return [result(context: context)]
        }
        return compareResult
    }

    private func compare(_ first: [RunScriptBuildPhaseDescriptor],
                         _ second: [RunScriptBuildPhaseDescriptor],
                         context: [String]) throws -> [CompareResult] {
        let count = max(first.count, second.count)
        return try (0 ..< count).map { try compare(first[safe: $0], second[safe: $0], context: context) }
    }

    private func compare(_ first: RunScriptBuildPhaseDescriptor?,
                         _ second: RunScriptBuildPhaseDescriptor?,
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

        let properties = first.differentValues(second: second)
        return result(context: context,
                      differentValues: properties)
    }

    private func descriptors(from target: PBXTarget) -> [RunScriptBuildPhaseDescriptor] {
        return target.buildPhases.compactMap {
            guard let runScriptBuildPhase = $0 as? PBXShellScriptBuildPhase else { return nil }

            return RunScriptBuildPhaseDescriptor(
                name: runScriptBuildPhase.name()!,
                inputPaths: runScriptBuildPhase.inputPaths,
                outputPaths: runScriptBuildPhase.outputPaths,
                inputFileListPaths: runScriptBuildPhase.inputFileListPaths,
                outputFileListPaths: runScriptBuildPhase.outputFileListPaths,
                shellPath: runScriptBuildPhase.shellPath,
                shellScript: runScriptBuildPhase.shellScript,
                showEnvVarsInLog: runScriptBuildPhase.showEnvVarsInLog,
                alwaysOutOfDate: runScriptBuildPhase.alwaysOutOfDate,
                dependencyFile: runScriptBuildPhase.dependencyFile
            )
        }
    }
}

private struct RunScriptBuildPhaseDescriptor: Equatable {
    let name: String
    let inputPaths: [String]?
    let outputPaths: [String]?
    let inputFileListPaths: [String]?
    let outputFileListPaths: [String]?
    let shellPath: String?
    let shellScript: String?
    let showEnvVarsInLog: Bool
    let alwaysOutOfDate: Bool
    let dependencyFile: String?

    func differentValues(second: RunScriptBuildPhaseDescriptor) -> [CompareResult.DifferentValues] {
        var result = [CompareResult.DifferentValues]()
        if inputPaths != second.inputPaths {
            result.append(.init(context: "inputPaths",
                                first: "\(describe(inputPaths))",
                                second: "\(describe(second.inputPaths))"))
        }
        if outputPaths != second.outputPaths {
            result.append(.init(context: "outputPaths",
                                first: "\(describe(outputPaths))",
                                second: "\(describe(second.outputPaths))"))
        }
        if shellPath != second.shellPath {
            result.append(.init(context: "shellPath",
                                first: "\(describe(shellPath))",
                                second: "\(describe(second.shellPath))"))
        }
        if shellScript != second.shellScript {
            result.append(.init(context: "shellScript",
                                first: "\(describe(shellScript))",
                                second: "\(describe(second.shellScript))"))
        }
        if showEnvVarsInLog != second.showEnvVarsInLog {
            result.append(.init(context: "showEnvVarsInLog",
                                first: "\(showEnvVarsInLog)",
                                second: "\(second.showEnvVarsInLog)"))
        }
        if alwaysOutOfDate != second.alwaysOutOfDate {
            result.append(.init(context: "alwaysOutOfDate",
                                first: "\(alwaysOutOfDate)",
                                second: "\(second.alwaysOutOfDate)"))
        }
        if dependencyFile != second.dependencyFile {
            result.append(.init(context: "dependencyFile",
                                first: "\(describe(dependencyFile))",
                                second: "\(describe(second.dependencyFile))"))
        }
        if inputFileListPaths != second.inputFileListPaths {
            result.append(.init(context: "inputFileListPaths",
                                first: "\(describe(inputFileListPaths))",
                                second: "\(describe(second.inputFileListPaths))"))
        }
        if outputFileListPaths != second.outputFileListPaths {
            result.append(.init(context: "outputFileListPaths",
                                first: "\(describe(outputFileListPaths))",
                                second: "\(describe(second.outputFileListPaths))"))
        }
        return result
    }
}
