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

struct SwiftPackageDescriptor: Hashable, CustomStringConvertible, Comparable {
    var name: String
    var url: String
    var version: String

    var identifier: String {
        return url
    }

    var description: String {
        return "\(name) (\(url)) \(version)"
    }

    func difference(from other: SwiftPackageDescriptor?) -> String? {
        guard let other = other else {
            return description
        }
        guard other != self else {
            return nil
        }
        var differences: [String] = []
        if name != other.name {
            differences.append("name = \(name)")
        }
        if url != other.url {
            differences.append("url = \(url)")
        }
        if version != other.version {
            differences.append("version = \(version)")
        }

        return differences.joined(separator: ", ")
    }

    static func < (lhs: SwiftPackageDescriptor, rhs: SwiftPackageDescriptor) -> Bool {
        return lhs.description < rhs.description
    }
}
