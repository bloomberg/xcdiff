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
import PathKit

public enum ComparatorError: LocalizedError {
    case generic(String)
    case cannotFind(type: String, elements: [String])

    public var errorDescription: String? {
        switch self {
        case let .generic(message):
            return message
        case let .cannotFind(type, elements):
            let formattedElemenets = elements.map { "\"\($0)\"" }.joined(separator: ", ")
            return "Cannot find \(type)\(elements.count > 1 ? "s" : "") \(formattedElemenets) in both projects"
        }
    }
}
