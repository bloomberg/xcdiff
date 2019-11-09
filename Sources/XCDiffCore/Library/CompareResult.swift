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
import XcodeProj

public struct CompareResult: GenericCompareResult, Equatable {
    public struct DifferentValues: Encodable, Equatable {
        public let context: String
        public let first: String
        public let second: String

        public init(context: String,
                    first: String? = nil,
                    second: String? = nil) {
            self.context = context
            self.first = first ?? "nil"
            self.second = second ?? "nil"
        }
    }

    public let tag: ComparatorTag
    public let context: [String]
    public let description: String?
    public let onlyInFirst: [String]
    public let onlyInSecond: [String]
    public let differentValues: [DifferentValues]

    public init(tag: ComparatorTag,
                context: [String] = [],
                description: String? = nil,
                onlyInFirst: [String] = [],
                onlyInSecond: [String] = [],
                differentValues: [DifferentValues] = []) {
        self.tag = tag
        self.context = context
        self.description = description
        self.onlyInFirst = onlyInFirst
        self.onlyInSecond = onlyInSecond
        self.differentValues = differentValues
    }

    public func same() -> Bool {
        return onlyInFirst.isEmpty
            && onlyInSecond.isEmpty
            && differentValues.isEmpty
    }
}
