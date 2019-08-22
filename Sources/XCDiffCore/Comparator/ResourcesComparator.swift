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

final class ResourcesComparator: Comparator {
    var tag = "resources"
    private let helper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try helper
            .commonTargets(first, second)
            .filter(by: parameters.targets)

        let compareResults = try commonTargets.map { targetPair -> CompareResult in
            let (first, second) = targetPair

            let firstPaths = Set(try helper.resources(from: first))
            let secondPaths = Set(try helper.resources(from: second))

            return result(context: ["\"\(first.name)\" target"],
                          first: firstPaths,
                          second: secondPaths,
                          differentValues: [])
        }

        return compareResults
    }
}
