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

// Inspired by http://www.russbishop.net/improving-optionals
// A type that has an empty value representation, as opposed to `nil`.
protocol EmptyValueRepresentable {
    /// Provide the empty value representation of the conforming type.
    static var emptyValue: Self { get }
}

extension Array: EmptyValueRepresentable {
    public static var emptyValue: [Element] { return [] }
}

extension Set: EmptyValueRepresentable {
    public static var emptyValue: Set<Element> { return Set() }
}

extension Dictionary: EmptyValueRepresentable {
    public static var emptyValue: [Key: Value] { return [:] }
}

extension String: EmptyValueRepresentable {
    public static var emptyValue: String { return "" }
}

extension Optional where Wrapped: EmptyValueRepresentable {
    /// If `self == nil` returns the empty value, otherwise returns the value.
    var valueOrEmpty: Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}
