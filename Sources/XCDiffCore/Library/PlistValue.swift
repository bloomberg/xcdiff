//
// Copyright 2025 Bloomberg Finance L.P.
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

public indirect enum PlistValue: Hashable {
    case string(String)
    case array([PlistValue])
    case dictionary([String: PlistValue])
}

extension PlistValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .string(string):
            return string
        case let .array(array):
            let elements = array.map { $0.description }
            return "[\(elements.joined(separator: ", "))]"
        case let .dictionary(dict):
            let pairs = dict.map { key, value in
                "\(key.description): \(value.description)"
            }.sorted()
            return "{\n\(pairs.joined(separator: "\n"))\n}"
        }
    }
}

// MARK: - Conversion utilities

public extension PlistValue {
    init(from anyValue: Any) {
        if let string = anyValue as? String {
            self = .string(string)
        } else if let bool = anyValue as? Bool {
            self = .string(String(bool))
        } else if let number = anyValue as? NSNumber {
            self = .string(number.stringValue)
        } else if let array = anyValue as? [Any] {
            self = .array(array.map { PlistValue(from: $0) })
        } else if let dict = anyValue as? [String: Any] {
            let convertedDict = dict.reduce(into: [String: PlistValue]()) { result, pair in
                result[pair.key] = PlistValue(from: pair.value)
            }
            self = .dictionary(convertedDict)
        } else {
            self = .string(String(describing: anyValue))
        }
    }
}
