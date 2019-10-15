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
        return results(context: ["NATIVE targets"],
                       first: targetsHelper.native(from: first).filter(by: parameters.targets),
                       second: targetsHelper.native(from: second).filter(by: parameters.targets))
            + results(context: ["AGGREGATE targets"],
                      first: targetsHelper.aggregate(from: first).filter(by: parameters.targets),
                      second: targetsHelper.aggregate(from: second).filter(by: parameters.targets))
    }
}
