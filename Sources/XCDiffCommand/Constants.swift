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
import TSCBasic
import TSCUtility

final class Constants {
    static let version: Version = {
        let identifiers = [
            debugVersionIdentifier(),
            gitHashVersionIdentifier(),
        ].compactMap { $0 }
        return Version(0, 9, 0, buildMetadataIdentifiers: identifiers)
    }()

    private static let gitHash = "#GIT_SHORT_HASH#"

    // MARK: - Init

    private init() {}

    // MARK: - Private

    private static func debugVersionIdentifier() -> String? {
        return debug ? "debug" : nil
    }

    private static func gitHashVersionIdentifier() -> String? {
        return !gitHash.hasPrefix("#") ? gitHash : "local"
    }

    private static var debug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}
