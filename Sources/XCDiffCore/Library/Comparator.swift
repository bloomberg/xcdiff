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

public struct ComparatorTag: RawRepresentable, ExpressibleByStringLiteral, Equatable, Encodable {
    public static let fileReferences: ComparatorTag = "file_references"
    public static let targets: ComparatorTag = "targets"
    public static let headers: ComparatorTag = "headers"
    public static let sources: ComparatorTag = "sources"
    public static let resources: ComparatorTag = "resources"
    public static let configurations: ComparatorTag = "configurations"
    public static let settings: ComparatorTag = "settings"
    public static let resolvedSettings: ComparatorTag = "resolved_settings"
    public static let sourceTrees: ComparatorTag = "source_trees"
    public static let dependencies: ComparatorTag = "dependencies"

    public typealias RawValue = String
    public var rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        rawValue = value
    }
}

public protocol Comparator {
    var tag: ComparatorTag { get }

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult]
}
