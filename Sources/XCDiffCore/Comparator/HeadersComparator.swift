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

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper
            .commonTargets(first, second)
            .filter(by: parameters.targets)

        return try commonTargets.map { firstTarget, secondTarget -> CompareResult in
            let firstHeaders = try targetsHelper.headers(from: firstTarget, sourceRoot: first.sourceRoot)
            let secondHeaders = try targetsHelper.headers(from: secondTarget, sourceRoot: second.sourceRoot)

            let firstPaths = Set(firstHeaders.map { $0.path })
            let secondPaths = Set(secondHeaders.map { $0.path })

            let commonHeaders = commonHeaderDescriptorPairs(first: firstHeaders, second: secondHeaders)
            let differentValues = attributesDifferences(in: commonHeaders)

            return result(context: ["\"\(secondTarget.name)\" target"],
                          first: firstPaths,
                          second: secondPaths,
                          differentValues: differentValues)
        }
    }

    // MARK: - Private

    /// Returns common header descriptors as a header descriptor pair
    private func commonHeaderDescriptorPairs(first: [HeaderDescriptor],
                                             second: [HeaderDescriptor]) -> [HeaderDescriptorPair] {
        let firstHeaderDescriptorMap = headerPathMap(from: first)
        let secondHeaderDescriptorMap = headerPathMap(from: second)

        let firstPaths = Set(firstHeaderDescriptorMap.keys)
        let secondPaths = Set(secondHeaderDescriptorMap.keys)

        let commonSources = firstPaths
            .intersection(secondPaths)
            .map { (firstHeaderDescriptorMap[$0]!, secondHeaderDescriptorMap[$0]!) }
            .sorted { left, right in left.0.path < right.0.path }

        return commonSources
    }

    /// Returns attributes differences between header pairs
    private func attributesDifferences(in headerDescriptorPairs: [HeaderDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return headerDescriptorPairs
            .filter { checkHeaderAttributesDifference(first: $0.attributes, second: $1.attributes) }
            .map { first, second in CompareResult.DifferentValues(context: "\(first.path) attributes",
                                                                  first: first.attributes ?? "Project",
                                                                  second: second.attributes ?? "Project") }
    }

    private func checkHeaderAttributesDifference(first: String?, second: String?) -> Bool {
        if first == "Private", second == "Private" {
            return false
        } else if first == "Public", second == "Public" {
            return false
        } else if first == nil, second == nil {
            return false
        }
        return true
    }

    /// Returns a dictionary that maps header descriptors by their path `[path: HeaderDescriptor]`
    private func headerPathMap(from headerDescriptors: [HeaderDescriptor]) -> [String: HeaderDescriptor] {
        return Dictionary(headerDescriptors.map { ($0.path, $0) }, uniquingKeysWith: { first, _ in first })
    }
}
