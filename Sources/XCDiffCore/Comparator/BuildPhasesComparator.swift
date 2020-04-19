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
import XcodeProj

final class BuildPhasesComparator: Comparator {
    let tag = "build_phases"
    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor, _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return try targetsHelper.commonTargets(first, second, parameters: parameters).map(compare)
    }

    // MARK: - Private

    private func compare(_ first: PBXTarget, _ second: PBXTarget) -> CompareResult {
        let context = ["\"\(first.name)\" target"]
        let firstDescriptors = first.buildPhases.map { $0.descriptor() }
        let secondDescriptors = second.buildPhases.map { $0.descriptor() }
        let firstIdentifiers = firstDescriptors.map { $0.identifier }
        let secondIdentifiers = secondDescriptors.map { $0.identifier }
        let onlyInFirst = self.onlyInFirst(firstIdentifiers, secondIdentifiers)
        let onlyInSecond = self.onlyInSecond(firstIdentifiers, secondIdentifiers)
        let differentValues = self.differentValues(firstDescriptors, secondDescriptors)
        return result(context: context,
                      onlyInFirst: onlyInFirst,
                      onlyInSecond: onlyInSecond,
                      differentValues: differentValues)
    }

    private func differentValues(_ first: [BuildPhaseDescriptor],
                                 _ second: [BuildPhaseDescriptor]) -> [CompareResult.DifferentValues] {
        return differentOrder(first, second) + differentProperties(first, second)
    }

    private func differentOrder(_ first: [BuildPhaseDescriptor],
                                _ second: [BuildPhaseDescriptor]) -> [CompareResult.DifferentValues] {
        let firstIdentifiers = first.map { $0.identifier }
        let secondIdentifiers = second.map { $0.identifier }
        let commonInFirst = self.commonInFirst(firstIdentifiers, secondIdentifiers)
        let commonInSecond = self.commonInSecond(firstIdentifiers, secondIdentifiers)
        let count = min(commonInFirst.count, commonInSecond.count)
        let commonFirstIdentifiers = commonInFirst[0 ..< count]
        let commonSecondIdentifiers = commonInSecond[0 ..< count]
        let firstValue = commonFirstIdentifiers.map { $0.description }.joined(separator: ", ")
        let secondValue = commonSecondIdentifiers.map { $0.description }.joined(separator: ", ")
        guard commonFirstIdentifiers == commonSecondIdentifiers else {
            return [CompareResult.DifferentValues(context: "Different order",
                                                  first: firstValue,
                                                  second: secondValue)]
        }
        return []
    }

    private func differentProperties(_ first: [BuildPhaseDescriptor],
                                     _ second: [BuildPhaseDescriptor]) -> [CompareResult.DifferentValues] {
        let firstIdentifiers = Set(first.map { $0.identifier })
        let secondIdentifiers = Set(second.map { $0.identifier })
        let firstDescriptorsByIdentifier = Dictionary(grouping: first) { $0.identifier }
        let secondDescriptorsByIdentifier = Dictionary(grouping: second) { $0.identifier }
        let commonIdentifiers = firstIdentifiers.intersection(secondIdentifiers)
        return commonIdentifiers.flatMap { identifier -> [CompareResult.DifferentValues] in
            let firstDescriptors = firstDescriptorsByIdentifier[identifier]!
            let secondDescriptors = secondDescriptorsByIdentifier[identifier]!
            let count = min(firstDescriptors.count, secondDescriptors.count)
            let result: [CompareResult.DifferentValues] = (0 ..< count).compactMap {
                let firstDescriptor = firstDescriptors[$0]
                let secondDescriptor = secondDescriptors[$0]
                guard firstDescriptor == secondDescriptor else {
                    let identifier = firstDescriptor.identifier.description
                    let firstProperties = firstDescriptor.properties(compareTo: secondDescriptor)
                    let secondProperties = secondDescriptor.properties(compareTo: firstDescriptor)
                    return CompareResult.DifferentValues(context: "Different properties in \"\(identifier)\"",
                                                         first: firstProperties,
                                                         second: secondProperties)
                }
                return nil
            }
            return result
        }
    }

    private func onlyInFirst(_ first: [BuildPhaseDescriptor.Identifier],
                             _ second: [BuildPhaseDescriptor.Identifier]) -> [String] {
        return second.reduce(first) { acc, value in
            guard let index = acc.firstIndex(of: value) else {
                return acc
            }
            var result = acc
            result.remove(at: index)
            return result
        }.map { $0.description }
    }

    private func onlyInSecond(_ first: [BuildPhaseDescriptor.Identifier],
                              _ second: [BuildPhaseDescriptor.Identifier]) -> [String] {
        return onlyInFirst(second, first)
    }

    private func commonInFirst(_ first: [BuildPhaseDescriptor.Identifier],
                               _ second: [BuildPhaseDescriptor.Identifier]) -> [BuildPhaseDescriptor.Identifier] {
        var secondIdentifiers = second
        var result = [BuildPhaseDescriptor.Identifier]()
        for firstValue in first {
            guard let index = secondIdentifiers.firstIndex(of: firstValue) else {
                continue
            }
            result.append(firstValue)
            secondIdentifiers.remove(at: index)
        }
        return result
    }

    private func commonInSecond(_ first: [BuildPhaseDescriptor.Identifier],
                                _ second: [BuildPhaseDescriptor.Identifier]) -> [BuildPhaseDescriptor.Identifier] {
        return commonInFirst(second, first)
    }
}

private extension PBXBuildPhase {
    func descriptor() -> BuildPhaseDescriptor {
        // looks like XcodeProj PBXBuildPhase.name() never returns nil
        return BuildPhaseDescriptor(identifier: .init(name: name()!, type: buildPhase),
                                    inputFileListPaths: inputFileListPaths,
                                    outputFileListPaths: outputFileListPaths,
                                    runOnlyForDeploymentPostprocessing: runOnlyForDeploymentPostprocessing)
    }
}

private struct BuildPhaseDescriptor: Equatable {
    struct Identifier: Hashable, CustomStringConvertible {
        let name: String
        let type: BuildPhase

        var description: String {
            guard name.lowercased() != type.rawValue.lowercased() else {
                return name
            }
            return "\(name) (\(type))"
        }
    }

    let identifier: Identifier
    let inputFileListPaths: [String]?
    let outputFileListPaths: [String]?
    let runOnlyForDeploymentPostprocessing: Bool

    func properties(compareTo second: BuildPhaseDescriptor) -> String {
        var elements = [String]()
        if runOnlyForDeploymentPostprocessing != second.runOnlyForDeploymentPostprocessing {
            elements.append("runOnlyForDeploymentPostprocessing = \(runOnlyForDeploymentPostprocessing)")
        }
        if inputFileListPaths.valueOrEmpty != second.inputFileListPaths.valueOrEmpty {
            elements.append("inputFileListPaths = \(describe(inputFileListPaths?.description))")
        }
        if outputFileListPaths.valueOrEmpty != second.outputFileListPaths.valueOrEmpty {
            elements.append("outputFileListPaths = \(describe(outputFileListPaths?.description))")
        }
        return elements.joined(separator: ", ")
    }

    static func == (lhs: BuildPhaseDescriptor, rhs: BuildPhaseDescriptor) -> Bool {
        lhs.identifier == rhs.identifier
            && lhs.runOnlyForDeploymentPostprocessing == rhs.runOnlyForDeploymentPostprocessing
            && lhs.inputFileListPaths.valueOrEmpty == rhs.inputFileListPaths.valueOrEmpty
            && lhs.outputFileListPaths.valueOrEmpty == rhs.outputFileListPaths.valueOrEmpty
    }
}
