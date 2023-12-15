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

final class LinkedDependenciesComparator: Comparator {
    private typealias DependencyDescriptorPair = (
        first: LinkedDependencyDescriptor,
        second: LinkedDependencyDescriptor
    )
    private let targetsHelper = TargetsHelper()
    private let buildFileComparatorHelper = BuildFileComparatorHelper()

    let tag = "linked_dependencies"

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)
        let results = try commonTargets.map { commonTarget in
            try createLinkedDependenciesResults(commonTarget: commonTarget)
        }

        return results
    }

    private func createLinkedDependenciesResults(commonTarget: TargetPair) throws -> CompareResult {
        let firstDependencies = try targetsHelper
            .linkedDependencies(from: commonTarget.first)
            .filter { $0.key != nil }
        let secondDependencies = try targetsHelper
            .linkedDependencies(from: commonTarget.second)
            .filter { $0.key != nil }

        return result(
            context: ["\"\(commonTarget.first.name)\" target"],
            first: firstDependencies,
            second: secondDependencies,
            diffCommonValues: { commonPairs in
                attributesDifferences(in: commonPairs)
                    + packageDifferences(in: commonPairs)
                    + buildFileComparatorHelper
                    .diff(
                        commonPairs.compactMap(buildFileDescriptorPair)
                    )
            }
        )
    }

    private func attributesDifferences(in dependencyDescriptorPairs: [DependencyDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return dependencyDescriptorPairs
            .filter { $0.type != $1.type }
            .compactMap { first, second -> CompareResult.DifferentValues? in
                if let key = first.key {
                    return .init(context: "\(key) attributes",
                                 first: first.type.rawValue,
                                 second: second.type.rawValue)
                }
                return nil
            }
    }

    private func packageDifferences(in dependencyDescriptorPairs: [DependencyDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return dependencyDescriptorPairs
            .filter { $0.package != $1.package }
            .compactMap { first, second -> CompareResult.DifferentValues? in
                if let key = first.key {
                    return .init(context: "\(key) package reference",
                                 first: first.package?.difference(from: second.package),
                                 second: second.package?.difference(from: first.package))
                }
                return nil
            }
    }

    private func buildFileDescriptorPair(
        from pair: DependencyDescriptorPair
    ) -> BuildFileComparatorHelper.BuildFileDescriptorPair? {
        guard let first = buildFileDescriptor(from: pair.first),
              let second = buildFileDescriptor(from: pair.second) else {
            return nil
        }
        return BuildFileComparatorHelper.BuildFileDescriptorPair(
            first: first,
            second: second
        )
    }

    private func buildFileDescriptor(
        from descriptor: LinkedDependencyDescriptor
    ) -> BuildFileDescriptor? {
        guard let key = descriptor.key else {
            return nil
        }

        return BuildFileDescriptor(
            name: key,
            platformFilters: descriptor.platformFilters,
            attributes: []
        )
    }
}
