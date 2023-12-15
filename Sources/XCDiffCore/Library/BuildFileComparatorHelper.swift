//
// Copyright 2023 Bloomberg Finance L.P.
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

final class BuildFileComparatorHelper {
    typealias BuildFileDescriptorPair = (
        first: BuildFileDescriptor,
        second: BuildFileDescriptor
    )

    func diff(
        _ buildFileDescriptorPairs: [BuildFileDescriptorPair]
    ) -> [CompareResult.DifferentValues] {
        buildFileDescriptorPairs
            .filter { $0 != $1 }
            .flatMap { first, second in
                var diffs: [CompareResult.DifferentValues] = []

                if first.attributes != second.attributes {
                    diffs.append(
                        CompareResult.DifferentValues(
                            context: "\(first.name) attributes",
                            first: describe(first.attributes),
                            second: describe(second.attributes)
                        )
                    )
                }

                if first.platformFilters != second.platformFilters {
                    diffs.append(
                        CompareResult.DifferentValues(
                            context: "\(first.name) platformFilters",
                            first: describe(first.platformFilters, default: "nil (Always Used)"),
                            second: describe(second.platformFilters, default: "nil (Always Used)")
                        )
                    )
                }

                return diffs
            }
    }
}
