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

final class TargetsComparator: Comparator {
    let tag = "targets"

    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        try targetsHelper.targets(from: first)
            .union(targetsHelper.targets(from: second))
            .validateTargetsOption(parameters)
        let nativeTargetResults = try compareNativeTargets(first, second, parameters: parameters)
        let aggregateTargetResults = compareAggregateTargets(first, second, parameters: parameters)
        let duplicates = try checkDuplicateTargets(first, second, parameters: parameters)
        return nativeTargetResults + aggregateTargetResults + duplicates
    }

    private func compareNativeTargets(_ first: ProjectDescriptor,
                                      _ second: ProjectDescriptor,
                                      parameters: ComparatorParameters) throws -> [CompareResult] {
        let firstTargets = targetsHelper.native(from: first).filter(by: parameters.targets)
        let secondTargets = targetsHelper.native(from: second).filter(by: parameters.targets)
        let commonTargets = try filteredCommonTargets(first, second, parameters: parameters)

        let commonTargetDifferences = commonTargets.filter {
            $0.first.productType != $0.second.productType
        }.map {
            CompareResult.DifferentValues(context: "\($0.first.name) product type",
                                          first: $0.first.productType?.rawValue,
                                          second: $0.second.productType?.rawValue)
        }

        return results(context: ["NATIVE targets"],
                       first: firstTargets,
                       second: secondTargets,
                       differentValues: commonTargetDifferences)
    }

    private func compareAggregateTargets(_ first: ProjectDescriptor,
                                         _ second: ProjectDescriptor,
                                         parameters: ComparatorParameters) -> [CompareResult] {
        return results(context: ["AGGREGATE targets"],
                       first: targetsHelper.aggregate(from: first).filter(by: parameters.targets),
                       second: targetsHelper.aggregate(from: second).filter(by: parameters.targets))
    }

    private func checkDuplicateTargets(
        _ first: ProjectDescriptor,
        _ second: ProjectDescriptor,
        parameters: ComparatorParameters
    ) throws -> [CompareResult] {
        let firstTargets = targetsHelper.allTargetNames(from: first).filter(by: parameters.targets)
        let secondTargets = targetsHelper.allTargetNames(from: second).filter(by: parameters.targets)
        let common = Set(firstTargets).intersection(Set(secondTargets))

        func duplicated(in names: [String]) -> [String] {
            Dictionary(grouping: names.filter { common.contains($0) }, by: { $0 })
                .filter { $0.value.count > 1 }
                .keys
                .sorted()
        }

        let duplicatesInFirst = duplicated(in: firstTargets)
        let duplicatesInSecond = duplicated(in: secondTargets)

        if duplicatesInFirst.isEmpty, duplicatesInSecond.isEmpty {
            return []
        }

        // Duplicates are flagged as diffs, even if both targets have the same set
        // this is due to xcdiff not being able to reliably diff match the correct duplicate
        return results(
            context: ["Duplicate targets"],
            onlyInFirst: duplicatesInFirst,
            onlyInSecond: duplicatesInSecond
        )
    }

    // A relaxed version of common targets that doesn't require
    // the specified targets filter (via parameters) to exist in both
    // targets.
    //
    // The specified targets could exist in both Native and Aggregate targets
    // hence why within this comparator we use this slightly more relaxed approach.
    private func filteredCommonTargets(_ first: ProjectDescriptor,
                                       _ second: ProjectDescriptor,
                                       parameters: ComparatorParameters) throws -> [TargetPair] {
        let allTargetsOption = ComparatorParameters(targets: .all, configurations: .all)
        let allCommonTargets = try targetsHelper.commonTargets(first, second, parameters: allTargetsOption)
        return allCommonTargets.filter(by: parameters.targets)
    }
}
