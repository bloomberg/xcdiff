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

final class AttributesComparator: Comparator {
    let tag = "attributes"

    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let projectAttributes = try compareProjectAttributes(first: first, second: second)
        let targetAttributes = try compareTargetAttributes(
            firstProject: first,
            secondProject: second,
            parameters: parameters
        )
        return [projectAttributes] + targetAttributes
    }

    // MARK: - Private

    private func compareProjectAttributes(first: ProjectDescriptor,
                                          second: ProjectDescriptor) throws -> CompareResult {
        let first = try targetsHelper.attributes(from: first.pbxproj)
        let second = try targetsHelper.attributes(from: second.pbxproj)
        return compareValues(
            context: ["Root project"],
            first: first,
            second: second
        )
    }

    private func compareTargetAttributes(
        firstProject: ProjectDescriptor,
        secondProject: ProjectDescriptor,
        parameters: ComparatorParameters
    ) throws -> [CompareResult] {
        try targetsHelper
            .commonTargets(firstProject, secondProject, parameters: parameters)
            .map { firstTarget, secondTarget in
                let first = try targetsHelper.targetAttributes(pbxproj: firstProject.pbxproj, target: firstTarget)
                let second = try targetsHelper.targetAttributes(pbxproj: secondProject.pbxproj, target: secondTarget)
                return compareValues(
                    context: ["\"\(firstTarget.name)\" target"],
                    first: first,
                    second: second
                )
            }
    }

    private func compareValues(
        context: [String],
        first: [String: String],
        second: [String: String]
    ) -> CompareResult {
        let firstKeys = Array(first.keys)
        let secondKeys = Array(second.keys)
        let commonKeys = firstKeys.commonSorted(secondKeys)

        let onlyInFirst = firstKeys.subtractingAndSorted(secondKeys).map {
            keyAndValue($0, attributes: first)
        }

        let onlyInSecond = secondKeys.subtractingAndSorted(firstKeys).map {
            keyAndValue($0, attributes: second)
        }

        let valueDifferences: [CompareResult.DifferentValues] = commonKeys.compactMap { name in
            let firstAttribute = first[name]
            let secondAttribute = second[name]
            guard firstAttribute == secondAttribute else {
                return .init(context: name,
                             first: firstAttribute,
                             second: secondAttribute)
            }

            return nil
        }

        return CompareResult(
            tag: tag,
            context: context,
            onlyInFirst: onlyInFirst,
            onlyInSecond: onlyInSecond,
            differentValues: valueDifferences
        )
    }

    private func keyAndValue(_ key: String, attributes: [String: String]) -> String {
        return "\(key) = \(attributes[key] ?? "nil")"
    }
}
