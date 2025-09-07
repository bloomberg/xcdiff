//
// Copyright 2025 Bloomberg Finance L.P.
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

final class PlistComparator: Comparator {
    let tag = "plists"

    private let targetsHelper: TargetsHelper

    convenience init() {
        self.init(targetsHelper: TargetsHelper())
    }

    init(targetsHelper: TargetsHelper) {
        self.targetsHelper = targetsHelper
    }

    func compare(
        _ first: ProjectDescriptor,
        _ second: ProjectDescriptor,
        parameters: ComparatorParameters
    ) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)

        return try commonTargets.flatMap { firstTarget, secondTarget in
            try compare(
                firstTarget: firstTarget,
                secondTarget: secondTarget,
                firstProject: first,
                secondProject: second
            )
        }
    }

    // MARK: - Private

    private func compare(
        firstTarget: PBXTarget,
        secondTarget: PBXTarget,
        firstProject: ProjectDescriptor,
        secondProject: ProjectDescriptor
    ) throws -> [CompareResult] {
        let firstPlists = targetsHelper.plists(from: firstTarget, sourceRoot: firstProject.sourceRoot)
        let secondPlists = targetsHelper.plists(from: secondTarget, sourceRoot: secondProject.sourceRoot)
        var results: [CompareResult] = []

        let firstPlistTypes = firstPlists.map(\.type)
        let secondPlistTypes = secondPlists.map(\.type)

        if firstPlistTypes != secondPlistTypes {
            let onlyInFirst = firstPlists
                .filter { !secondPlistTypes.contains($0.type) }
                .map(\.name)

            let onlyInSecond = secondPlists
                .filter { !firstPlistTypes.contains($0.type) }
                .map(\.name)

            results.append(
                result(
                    context: ["\"\(firstTarget.name)\" target"],
                    onlyInFirst: onlyInFirst,
                    onlyInSecond: onlyInSecond
                )
            )
        }

        for (firstDescriptor, secondDescriptor) in zip(firstPlists, secondPlists) {
            guard firstDescriptor.type == secondDescriptor.type else { continue }

            let comparedResult = comparePlist(firstDescriptor.plist, secondDescriptor.plist)

            guard !comparedResult.isEmpty else {
                results.append(
                    result(
                        context: [
                            "\"\(firstTarget.name)\" target",
                            "\(firstDescriptor.name) - \(secondDescriptor.name)",
                        ],
                        onlyInFirst: [],
                        onlyInSecond: []
                    )
                )
                continue
            }

            results.append(
                result(
                    context: ["\"\(firstTarget.name)\" target", "\(firstDescriptor.name) - \(secondDescriptor.name)"],
                    onlyInFirst: comparedResult.onlyInFirst,
                    onlyInSecond: comparedResult.onlyInSecond,
                    differentValues: comparedResult.differentValues
                )
            )
        }

        return results
    }

    private func comparePlist(_ lhs: PlistValue, _ rhs: PlistValue, context: String = "") -> CompareResult {
        switch (lhs, rhs) {
        case let (.dictionary(lhsDict), .dictionary(rhsDict)):
            return compareDictionaries(lhsDict, rhsDict, context: context)
        case let (.array(lhsArray), .array(rhsArray)):
            return compareArrays(lhsArray, rhsArray, context: context)
        case let (.string(lhsString), .string(rhsString)) where lhsString != rhsString:
            return result(
                context: [context],
                differentValues: [
                    .init(
                        context: context,
                        first: lhsString,
                        second: rhsString
                    ),
                ]
            )
        case _ where lhs.description != rhs.description:
            return result(
                context: [context],
                differentValues: [
                    .init(
                        context: context,
                        first: lhs.description,
                        second: rhs.description
                    ),
                ]
            )
        default:
            return result(context: [], onlyInFirst: [], onlyInSecond: [])
        }
    }

    private func compareDictionaries(
        _ lhs: [String: PlistValue],
        _ rhs: [String: PlistValue],
        context: String
    ) -> CompareResult {
        var results: [CompareResult] = []

        let lhsKeys = Set(lhs.keys)
        let rhsKeys = Set(rhs.keys)
        let commonKeys = lhsKeys.intersection(rhsKeys)

        let onlyInLhs = lhsKeys.subtracting(rhsKeys).sorted()
        if !onlyInLhs.isEmpty {
            results.append(
                result(
                    context: [context],
                    onlyInFirst: onlyInLhs
                )
            )
        }

        let onlyInRhs = rhsKeys.subtracting(lhsKeys).sorted()
        if !onlyInRhs.isEmpty {
            results.append(
                result(
                    context: [context],
                    onlyInSecond: onlyInRhs
                )
            )
        }

        for key in commonKeys.sorted() {
            let lhsValue = lhs.first { $0.key == key }?.value
            let rhsValue = rhs.first { $0.key == key }?.value

            if let lhsVal = lhsValue, let rhsVal = rhsValue {
                let newContext = [context, key].filter { !$0.isEmpty }.joined(separator: ".")
                results.append(comparePlist(lhsVal, rhsVal, context: newContext))
            }
        }

        return result(
            context: results.flatMap(\.context),
            onlyInFirst: results.flatMap(\.onlyInFirst),
            onlyInSecond: results.flatMap(\.onlyInSecond),
            differentValues: results.flatMap(\.differentValues)
        )
    }

    private func compareArrays(
        _ lhs: [PlistValue],
        _ rhs: [PlistValue],
        context: String
    ) -> CompareResult {
        var allResults: [CompareResult] = []

        // Step 1: Find unique string items (items that exist only in one dimension array)
        let lhsStringSet = Set(lhs.compactMap { item -> String? in
            guard case let .string(value) = item else { return nil }
            return value
        })

        let rhsStringSet = Set(rhs.compactMap { item -> String? in
            guard case let .string(value) = item else { return nil }
            return value
        })

        let onlyInLhs = Array(lhsStringSet.subtracting(rhsStringSet)).sorted()
        let onlyInRhs = Array(rhsStringSet.subtracting(lhsStringSet)).sorted()

        if !onlyInLhs.isEmpty || !onlyInRhs.isEmpty {
            allResults.append(
                result(
                    context: [context],
                    differentValues: [
                        .init(
                            context: context,
                            first: onlyInLhs.joined(separator: ", ").nilIfEmpty,
                            second: onlyInRhs.joined(separator: ", ").nilIfEmpty
                        ),
                    ]
                )
            )
        }

        // Step 2: Compare items by position for nested structure differences
        for (index, (lhsItem, rhsItem)) in zip(lhs, rhs).enumerated() {
            // Step 3: Skip string values because we handle it in Step 1
            if case .string = lhsItem, case .string = rhsItem { continue }

            let itemContext = "\(context)[\(index)]"
            let itemResult = comparePlist(lhsItem, rhsItem, context: itemContext)
            if !itemResult.isEmpty {
                allResults.append(itemResult)
            }
        }

        let nonEmptyResults = allResults.filter { !$0.isEmpty }
        return result(
            context: nonEmptyResults.flatMap(\.context),
            onlyInFirst: nonEmptyResults.flatMap(\.onlyInFirst),
            onlyInSecond: nonEmptyResults.flatMap(\.onlyInSecond),
            differentValues: nonEmptyResults.flatMap(\.differentValues)
        )
    }
}

private extension CompareResult {
    var isEmpty: Bool {
        onlyInFirst.isEmpty && onlyInSecond.isEmpty && differentValues.isEmpty
    }
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
