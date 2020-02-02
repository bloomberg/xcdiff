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
import XcodeProj

final class DependenciesComparator: Comparator {
    let tag = "dependencies"

    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return try targetsHelper
            .commonTargets(first, second, parameters: parameters)
            .flatMap { try compare($0, $1) }
    }

    // MARK: - Private

    private func compare(_ first: PBXTarget, _ second: PBXTarget) throws -> [CompareResult] {
        let firstNames = first.dependencies.map { $0.name ?? $0.target!.name }.toSet()
        let secondNames = second.dependencies.map { $0.name ?? $0.target!.name }.toSet()
        return results(context: ["\"\(first.name)\" target"],
                       first: firstNames,
                       second: secondNames)
    }
}
