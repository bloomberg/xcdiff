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
import XcodeProj

class SettingsHelper {
    func compareSettingsValues(tag: String,
                               parentContext: [String],
                               _ first: BuildSettings,
                               _ second: BuildSettings) throws -> CompareResult {
        let firstKeys = Array(first.keys)
        let secondKeys = Array(second.keys)
        let commonKeys = firstKeys.commonSorted(secondKeys)
        let onlyInFirst = firstKeys.subtractingAndSorted(secondKeys).map { keyAndValue($0, buildSettings: first) }
        let onlyInSecond = secondKeys.subtractingAndSorted(firstKeys).map { keyAndValue($0, buildSettings: second) }

        // we attempt to ignore differences that are a result of different project names
        let firstProjectName = first["PROJECT_NAME"]?.stringValue
        let secondProjectName = second["PROJECT_NAME"]?.stringValue
        let settingValueComparator = SettingValueComparator(firstProjectName: firstProjectName,
                                                            secondProjectName: secondProjectName)

        let valueDifferences: [CompareResult.DifferentValues] = commonKeys.compactMap { settingName in
            let firstSetting = first[settingName]
            let secondSettings = second[settingName]
            let firstString = stringFromBuildSetting(firstSetting)
            let secondString = stringFromBuildSetting(secondSettings)
            guard settingValueComparator.compare(firstString, secondString) == .orderedSame else {
                return .init(context: settingName,
                             first: firstString,
                             second: secondString)
            }

            return nil
        }
        return CompareResult(tag: tag,
                             context: parentContext + ["Values"],
                             onlyInFirst: onlyInFirst,
                             onlyInSecond: onlyInSecond,
                             differentValues: valueDifferences)
    }

    // MARK: - Private

    private func keyAndValue(_ key: String, buildSettings: BuildSettings) -> String {
        return "\(key) = \(buildSettings[key]?.settingDiffValue ?? "nil")"
    }

    private func stringFromBuildSetting(_ buildSetting: BuildSetting?) -> String {
        buildSetting?.stringValue ?? "nil"
    }
}

extension BuildSetting {
    var settingDiffValue: String {
        switch self {
        case let .string(value):
            value
        case let .array(value):
            "\(value)"
        }
    }
}
