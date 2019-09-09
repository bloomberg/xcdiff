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

protocol Diff {
    associatedtype T

    func diff(_ lha: T, _ rha: T) -> T
}

final class SuffixStringDiff: Diff {
    typealias T = String

    func diff(_ lha: String, _ rha: String) -> String {
        let (longVal, shortVal) = lha.count > rha.count ? (lha, rha) : (rha, lha)
        var longIndex = longVal.startIndex, shortIndex = shortVal.startIndex
        var diff = ""
        while longIndex < longVal.endIndex, shortIndex < shortVal.endIndex {
            if longVal[longIndex] == shortVal[shortIndex] {
                shortIndex = shortVal.index(after: shortIndex)
                longIndex = longVal.index(after: longIndex)
            } else {
                diff.append(longVal[longIndex])
                longIndex = longVal.index(after: longIndex)
            }
        }

        while longIndex < longVal.endIndex {
            diff.append(longVal[longIndex])
            longIndex = longVal.index(after: longIndex)
        }

        while shortIndex < shortVal.endIndex {
            diff.append(shortVal[shortIndex])
            shortIndex = shortVal.index(after: shortIndex)
        }

        return diff
    }
}
