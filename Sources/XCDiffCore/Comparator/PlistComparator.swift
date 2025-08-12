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
import PathKit
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
        let firstPlists = allPlists(from: firstTarget, sourceRoot: firstProject.sourceRoot)
        let secondPlists = allPlists(from: secondTarget, sourceRoot: secondProject.sourceRoot)
        let plists = Set(firstPlists.keys).union(Set(secondPlists.keys))
        var results: [CompareResult] = []

        for key in plists.sorted() {
            let firstDescriptor = firstPlists[key]
            let secondDescriptor = secondPlists[key]
            
            guard let firstDescriptor,
                  let secondDescriptor,
                  !firstDescriptor.plist.isEmpty,
                  !secondDescriptor.plist.isEmpty
            else {
                if let firstDescriptor, !firstDescriptor.plist.isEmpty {
                    results.append(result(
                        context: ["\(key) plist"],
                        onlyInFirst: [firstDescriptor.path.string]
                    ))
                }
                
                if let secondDescriptor, !secondDescriptor.plist.isEmpty  {
                    results.append(result(
                        context: ["\(key) plist"],
                        onlyInSecond: [secondDescriptor.path.string]
                    ))
                }
                
                continue
            }
            
            results.append(contentsOf: comparePlist(
                first: firstDescriptor.plist,
                second: secondDescriptor.plist,
                context: "\(key).plist"
            ))
        }
        
        return results
    }
    
    private func allPlists(from target: PBXTarget, sourceRoot: Path) -> [String: PlistDescriptor] {
        var plists: [String: PlistDescriptor] = [:]
        
        if let infoPlist = try? targetsHelper.infoPlist(target: target, sourceRoot: sourceRoot) {
            plists["Info"] = infoPlist
        }

        return plists
    }

    private func comparePlist(
        first: Plist,
        second: Plist,
        context: String
    ) -> [CompareResult] {
        var results: [CompareResult] = []
        let firstKeys = Set(first.keys)
        let secondKeys = Set(second.keys)
        let commonKeys = firstKeys.intersection(secondKeys)

        for key in firstKeys.subtracting(secondKeys).sorted() {
            results.append(
                result(
                    context: ["\(context).\(key)"],
                    onlyInFirst: [stringValue(first[key])]
                )
            )
        }

        for key in secondKeys.subtracting(firstKeys).sorted() {
            results.append(
                result(
                    context: ["\(context).\(key)"],
                    onlyInSecond: [stringValue(second[key])]
                )
            )
        }

        for key in commonKeys.sorted() {
            let firstValue = first[key]
            let secondValue = second[key]
            
            results.append(contentsOf: compareValues(
                first: firstValue,
                second: secondValue,
                context: "\(context).\(key)"
            ))
        }

        return results
    }

    private func compareValues(
        first: Any?,
        second: Any?,
        context: String
    ) -> [CompareResult] {
        var results: [CompareResult] = []
        var differences: [CompareResult.DifferentValues] = []

        switch (first, second) {
        case let (firstDict as Plist, secondDict as Plist):
            results.append(contentsOf: comparePlist(
                first: firstDict,
                second: secondDict,
                context: context
            ))

        case let (firstArray as [Any], secondArray as [Any]):
            let maxCount = max(firstArray.count, secondArray.count)
            for i in 0 ..< maxCount {
                let firstItem = i < firstArray.count ? firstArray[i] : nil
                let secondItem = i < secondArray.count ? secondArray[i] : nil

                switch (firstItem, secondItem) {
                case let (firstVal?, secondVal?):
                    let nestedDifferences = compareValues(
                        first: firstVal,
                        second: secondVal,
                        context: "\(context)"
                    )
                    results.append(contentsOf: nestedDifferences)
                case let (firstVal?, nil):
                    results.append(
                        result(
                            context: ["\(context)[\(i)]"],
                            onlyInFirst: [stringValue(firstVal)]
                        )
                    )
                case let (nil, secondVal?):
                    results.append(
                        result(
                            context: ["\(context)[\(i)]"],
                            onlyInSecond: [stringValue(secondVal)]
                        )
                    )
                case (nil, nil):
                    break
                }
            }

        default:
            let firstString = stringValue(first)
            let secondString = stringValue(second)
            if firstString != secondString {
                differences.append(
                    CompareResult.DifferentValues(
                        context: context,
                        first: firstString,
                        second: secondString
                    )
                )
            }
        }
        
        if !differences.isEmpty {
            results.append(
                result(
                    context: [context],
                    differentValues: differences
                )
            )
        }

        return results
    }

    /// Converts any plist value to a readable string representation
    private func stringValue(_ value: Any?) -> String {
        guard let value = value else { return "<nil>" }

        switch value {
        case let array as [Any]:
            let elements = array.map { stringValue($0) }
            return "[\(elements.joined(separator: ", "))]"
        case let dict as [String: Any]:
            let pairs = dict.map { key, val in
                "\(key): \(stringValue(val))"
            }.sorted()
            return "{\(pairs.joined(separator: ", "))}"
        default:
            return String(describing: value)
        }
    }
}
