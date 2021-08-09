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
import PathKit
import XcodeProj

final class SwiftPackagesComparator: Comparator {
    let tag = "swift_packages"
    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters _: ComparatorParameters) throws -> [CompareResult] {
        let firstPackages = try targetsHelper.swiftPackages(in: first)
        let secondPackages = try targetsHelper.swiftPackages(in: second)

        let firstDictionary = Dictionary(firstPackages.map { ($0.identifier, $0) }, uniquingKeysWith: { $1 })
        let secondDictionary = Dictionary(secondPackages.map { ($0.identifier, $0) }, uniquingKeysWith: { $1 })

        let onlyInFirst = firstPackages.filter { secondDictionary[$0.identifier] == nil }
        let onlyInSecond = secondPackages.filter { firstDictionary[$0.identifier] == nil }
        let common = firstPackages.filter { secondDictionary[$0.identifier] != nil }
        let differences = common.filter {
            firstDictionary[$0.identifier] != secondDictionary[$0.identifier]
        }

        let differencesValues: [CompareResult.DifferentValues] = differences.compactMap {
            guard let first = firstDictionary[$0.identifier],
                  let second = secondDictionary[$0.identifier] else {
                return nil
            }

            return CompareResult.DifferentValues(
                context: "\($0.name) (\($0.url))",
                first: first.difference(from: second),
                second: second.difference(from: first)
            )
        }

        return [
            CompareResult(
                tag: tag,
                onlyInFirst: onlyInFirst.map(\.description),
                onlyInSecond: onlyInSecond.map(\.description),
                differentValues: differencesValues
            ),
        ]
    }
}
