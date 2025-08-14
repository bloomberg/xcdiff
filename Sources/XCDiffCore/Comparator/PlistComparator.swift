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

    init(targetsHelper: TargetsHelper = TargetsHelper()) {
        self.targetsHelper = targetsHelper
    }

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
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
        let firstPlists = targetsHelper.allPlists(from: firstTarget, sourceRoot: firstProject.sourceRoot)
        let secondPlists = targetsHelper.allPlists(from: secondTarget, sourceRoot: secondProject.sourceRoot)
        let plists = Set(firstPlists.keys).union(Set(secondPlists.keys))
        var results: [CompareResult] = []

        for plistType in plists.sorted() {
            let firstDescriptor = firstPlists[plistType]
            let secondDescriptor = secondPlists[plistType]

            guard let firstDescriptor,
                  let secondDescriptor
            else {
                results.append(
                    comparedPlistContexts(firstDescriptor, secondDescriptor)
                )
                continue
            }

            let comparedResult = comparePlist(firstDescriptor.plist, secondDescriptor.plist)
            guard !comparedResult.isEmpty else {
                results.append(
                    comparedPlistContexts(firstDescriptor, secondDescriptor)
                )
                continue
            }
            results.append(result(
                context: ["\(firstDescriptor.plistName) > \(secondDescriptor.plistName)"],
                onlyInFirst: comparedResult.onlyInFirst,
                onlyInSecond: comparedResult.onlyInSecond,
                differentValues: comparedResult.differentValues
            ))
        }

        return results
    }

    private func comparePlist(_ lhs: PlistValue, _ rhs: PlistValue, context: String = "") -> CompareResult {
        switch (lhs, rhs) {
        case let (.dictionary(lhsDict), .dictionary(rhsDict)):
            return compareDictionaries(lhsDict, rhsDict, context: context)
        case let (.array(lhsArray), .array(rhsArray)):
            return compareArrays(lhsArray, rhsArray, context: context)
        case let (.string(lhsString), .string(rhsString)):
            if lhsString != rhsString {
                return result(
                    context: [context],
                    differentValues: [.init(
                        context: context,
                        first: lhsString,
                        second: rhsString
                    )]
                )
            }
            return result(context: [], onlyInFirst: [], onlyInSecond: [])
        default:
            return result(
                context: [context],
                differentValues: [.init(
                    context: context,
                    first: lhs.description,
                    second: rhs.description
                )]
            )
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

        let onlyInFirst = lhsKeys.subtracting(rhsKeys).sorted()
        if !onlyInFirst.isEmpty {
            results.append(result(
                context: [context],
                onlyInFirst: onlyInFirst
            ))
        }

        let onlyInSecond = rhsKeys.subtracting(lhsKeys).sorted()
        if !onlyInSecond.isEmpty {
            results.append(result(
                context: [context],
                onlyInSecond: onlyInSecond
            ))
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

    private func compareArrays(_ lhs: [PlistValue], _ rhs: [PlistValue], context: String) -> CompareResult {
        var results: [CompareResult] = []
        let maxCount = max(lhs.count, rhs.count)

        for index in 0 ..< maxCount {
            let firstItem = index < lhs.count ? lhs[index] : nil
            let secondItem = index < rhs.count ? rhs[index] : nil

            switch (firstItem, secondItem) {
            case let (firstVal?, secondVal?):
                results.append(
                    comparePlist(firstVal, secondVal, context: context)
                )
            case let (firstVal?, nil):
                results.append(result(
                    context: [context],
                    onlyInFirst: [firstVal.description]
                ))
            case let (nil, secondVal?):
                results.append(result(
                    context: [context],
                    onlyInSecond: [secondVal.description]
                ))
            case (nil, nil):
                break
            }
        }

        return result(
            context: results.flatMap(\.context),
            onlyInFirst: results.flatMap(\.onlyInFirst),
            onlyInSecond: results.flatMap(\.onlyInSecond),
            differentValues: results.flatMap(\.differentValues)
        )
    }

    private func comparedPlistContexts(_ lhs: PlistDescriptor?, _ rhs: PlistDescriptor?) -> CompareResult {
        let context = [lhs?.plistName, rhs?.plistName].compactMap { $0 }

        return result(
            context: context,
            onlyInFirst: [],
            onlyInSecond: []
        )
    }
}

private extension CompareResult {
    var isEmpty: Bool {
        onlyInFirst.isEmpty && onlyInSecond.isEmpty && differentValues.isEmpty
    }
}
