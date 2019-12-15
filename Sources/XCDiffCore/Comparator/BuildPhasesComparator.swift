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
        let count = max(firstDescriptors.count, secondDescriptors.count)
        let differentValues: [CompareResult.DifferentValues] = (0 ..< count).compactMap { index in
            let context = "Build Phase \(index + 1)"
            guard let firstDescriptor = firstDescriptors[safe: index] else {
                return .init(context: context,
                             first: nil,
                             second: secondDescriptors[index].description)
            }
            guard let secondDescriptor = secondDescriptors[safe: index] else {
                return .init(context: context,
                             first: firstDescriptors[index].description,
                             second: nil)
            }
            guard firstDescriptor == secondDescriptor else {
                return .init(context: context,
                             first: firstDescriptor.description,
                             second: secondDescriptor.description)
            }
            return nil
        }
        return result(context: context, differentValues: differentValues)
    }
}

private extension PBXBuildPhase {
    func descriptor() -> BuildPhaseDescriptor {
        return BuildPhaseDescriptor(name: name(),
                                    type: type(),
                                    inputFileListPaths: inputFileListPaths,
                                    outputFileListPaths: outputFileListPaths,
                                    runOnlyForDeploymentPostprocessing: runOnlyForDeploymentPostprocessing)
    }
}

private struct BuildPhaseDescriptor: Equatable, CustomStringConvertible {
    let name: String?
    let type: BuildPhase?
    let inputFileListPaths: [String]?
    let outputFileListPaths: [String]?
    let runOnlyForDeploymentPostprocessing: Bool

    var description: String {
        var elements = [String]()
        elements.append("name = \(name ?? "nil")")
        elements.append("type = \(type?.rawValue ?? "nil")")
        elements.append("runOnlyForDeploymentPostprocessing = \(runOnlyForDeploymentPostprocessing)")
        if let inputFileListPaths = inputFileListPaths {
            elements.append("inputFileListPaths = \(inputFileListPaths.description)")
        }
        if let outputFileListPaths = outputFileListPaths {
            elements.append("outputFileListPaths = \(outputFileListPaths.description)")
        }
        return elements.joined(separator: ", ")
    }
}
