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

final class ConfigurationsComparator: Comparator {
    let tag = Comparators.Tags.configurations

    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let firstConfigurations = targetsHelper
            .configurations(from: first)
            .filter(by: parameters.configurations)
        let secondConfigurations = targetsHelper
            .configurations(from: second)
            .filter(by: parameters.configurations)
        return results(context: ["Root project"],
                       first: firstConfigurations,
                       second: secondConfigurations)
    }
}
