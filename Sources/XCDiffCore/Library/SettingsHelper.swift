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

class SettingsHelper {
    func stringFromBuildSetting(_ buildSetting: Any?) throws -> String {
        // try to unwrap
        guard let buildSetting = buildSetting else {
            return "nil"
        }

        // try to cast to string
        if let buildSettingString = buildSetting as? String {
            return buildSettingString
        }

        // try to case to array
        if let buildSettingArray = buildSetting as? NSArray {
            return buildSettingArray.compactMap { $0 as? String }.joined(separator: " ")
        }

        throw ComparatorError.generic("Cannot convert build setting to string")
    }
}
