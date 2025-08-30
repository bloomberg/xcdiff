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

struct PlistDescriptor: Equatable, Hashable {
    private var identifier: String { "\(target) (\(path))" }

    let target: String
    let plist: PlistValue
    let path: Path
    let type: PlistType
    var name: String { path.lastComponent }

    init(target: String, path: Path, plistData: Data, type: PlistType) throws {
        let anyValue = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
        self.init(target: target, path: path, plistValue: PlistValue(from: anyValue), type: type)
    }

    init(target: String, path: Path, plistValue: PlistValue, type: PlistType) {
        self.target = target
        self.path = path
        plist = plistValue
        self.type = type
    }
}

extension PlistDescriptor: DiffComparable {
    var diffKey: String { identifier }
}

extension PlistDescriptor: CustomStringConvertible {
    var description: String { identifier }
}

extension PlistDescriptor {
    enum PlistType {
        case info
        case entitlements

        var buildSettingsKey: String {
            switch self {
            case .info: "INFOPLIST_FILE"
            case .entitlements: "CODE_SIGN_ENTITLEMENTS"
            }
        }
    }
}
