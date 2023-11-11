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

        return [
            result(
                first: firstPackages,
                second: secondPackages,
                diffCommonValues: { commonPairs in
                    commonPairs.filter {
                        $0 != $1
                    }.map { first, second in
                        CompareResult.DifferentValues(
                            context: "\(first.name) (\(first.url))",
                            first: first.difference(from: second),
                            second: second.difference(from: first)
                        )
                    }
                }
            ),
        ]
    }
}
