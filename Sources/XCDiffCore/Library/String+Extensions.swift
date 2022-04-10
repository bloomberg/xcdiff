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

extension String {
    func split(around delimiter: String) -> (String, String?) {
        var start = startIndex
        while let index = index(start, offsetBy: delimiter.count, limitedBy: endIndex) {
            if self[start ..< index] == delimiter {
                let leading = self[startIndex ..< start]
                guard index != endIndex else {
                    return (String(leading), "")
                }
                let trailing = self[index...]
                return (String(leading), String(trailing))
            } else {
                start = self.index(start, offsetBy: 1)
            }
        }
        return (self, nil)
    }
}

func describe<T: CustomStringConvertible>(_ value: T?) -> String {
    return value?.description ?? "nil"
}
