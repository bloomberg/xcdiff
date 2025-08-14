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

struct PlistDescriptor {
    private var identifier: String { "\(target) (\(path))" }

    let target: String
    let plist: PlistValue
    let path: Path
    
    var plistName: String { path.lastComponent }
}

extension PlistDescriptor: DiffComparable, Equatable, Hashable {
    static func == (lhs: PlistDescriptor, rhs: PlistDescriptor) -> Bool {
        lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    var diffKey: String { identifier }
}

extension PlistDescriptor: CustomStringConvertible {
    var description: String { identifier }
}

extension PlistDescriptor {
    static var infoPlistKey: String { "INFOPLIST_FILE" }
    static var entitlementsPlistKey: String { "CODE_SIGN_ENTITLEMENTS" }
}
