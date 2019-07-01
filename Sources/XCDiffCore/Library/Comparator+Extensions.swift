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

extension Comparator {
    func result(context: [String] = [],
                description: String? = nil,
                onlyInFirst: [String] = [],
                onlyInSecond: [String] = [],
                differences: [CompareResult.DifferentValues] = []) -> CompareResult {
        return CompareResult(tag: tag,
                             context: context,
                             description: description,
                             onlyInFirst: onlyInFirst,
                             onlyInSecond: onlyInSecond,
                             differentValues: differences)
    }

    func result(context: [String] = [],
                description: String? = nil,
                first: Set<String> = [],
                second: Set<String> = [],
                differences: [CompareResult.DifferentValues] = []) -> CompareResult {
        return result(context: context,
                      description: description,
                      onlyInFirst: first.subtracting(second).sorted(),
                      onlyInSecond: second.subtracting(first).sorted(),
                      differences: differences)
    }
}

extension Comparator {
    func results(context: [String] = [],
                 description: String? = nil,
                 onlyInFirst: [String] = [],
                 onlyInSecond: [String] = [],
                 differences: [CompareResult.DifferentValues] = []) -> [CompareResult] {
        return [result(context: context,
                       description: description,
                       onlyInFirst: onlyInFirst,
                       onlyInSecond: onlyInSecond,
                       differences: differences)]
    }

    func results(context: [String] = [],
                 description: String? = nil,
                 first: Set<String> = [],
                 second: Set<String> = [],
                 differences: [CompareResult.DifferentValues] = []) -> [CompareResult] {
        return [result(context: context,
                       description: description,
                       first: first,
                       second: second,
                       differences: differences)]
    }
}
