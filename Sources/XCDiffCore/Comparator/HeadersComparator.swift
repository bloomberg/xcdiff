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

final class HeadersComparator: Comparator {
    private typealias HeaderDescriptorPair = (first: HeaderDescriptor, second: HeaderDescriptor)

    let tag = "headers"
    private let targetsHelper = TargetsHelper()
    private let buildFileComparatorHelper = BuildFileComparatorHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)
        return try commonTargets.map { firstTarget, secondTarget -> CompareResult in
            let firstHeaders = try targetsHelper.headers(from: firstTarget, sourceRoot: first.sourceRoot)
            let secondHeaders = try targetsHelper.headers(from: secondTarget, sourceRoot: second.sourceRoot)

            return result(
                context: ["\"\(secondTarget.name)\" target"],
                first: firstHeaders,
                second: secondHeaders,
                diffCommonValues: { commonPairs in
                    let differentValues = self.attributesDifferences(in: commonPairs)
                    let buildFileDifferences = self.buildFileComparatorHelper.diff(
                        commonPairs.map(self.buildFileDescriptorPair)
                    )

                    return differentValues + buildFileDifferences
                }
            )
        }
    }

    // MARK: - Private

    /// Returns attributes differences between header pairs
    private func attributesDifferences(
        in headerDescriptorPairs: [HeaderDescriptorPair]
    ) -> [CompareResult.DifferentValues] {
        return headerDescriptorPairs
            .filter { $0.attributes != $1.attributes }
            .map { first, second in
                CompareResult.DifferentValues(
                    context: "\(first.path) attributes",
                    first: first.attributes ?? "nil (Project)",
                    second: second.attributes ?? "nil (Project)"
                )
            }
    }

    private func buildFileDescriptorPair(
        from headerDescriptorPair: HeaderDescriptorPair
    ) -> BuildFileComparatorHelper.BuildFileDescriptorPair {
        (
            first: buildFileDescriptor(from: headerDescriptorPair.first),
            second: buildFileDescriptor(from: headerDescriptorPair.second)
        )
    }

    private func buildFileDescriptor(
        from descriptor: HeaderDescriptor
    ) -> BuildFileDescriptor {
        return BuildFileDescriptor(
            name: descriptor.path,
            platformFilters: descriptor.platformFilters,
            attributes: []
        )
    }
}
