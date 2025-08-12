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
import PathKit

typealias Plist = [String: Any]

struct PlistDescriptor {
    private var id: String { "\(target) (\(path))" }
    
    let target: String
    let plist: Plist
    let path: Path
}

extension PlistDescriptor: DiffComparable, Equatable, Hashable {
    static func == (lhs: PlistDescriptor, rhs: PlistDescriptor) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var diffKey: String { id }
}

extension PlistDescriptor: CustomStringConvertible {
    var description: String { id }
}

extension PlistDescriptor {
    static var infoPlistKey: String { "INFOPLIST_FILE" }
}
