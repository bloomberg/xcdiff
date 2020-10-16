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

final class ResolvedSettingsComparator: Comparator {
    private typealias TargetProjectTuple = (target: PBXTarget, projectDescriptor: ProjectDescriptor)

    let tag = "resolved_settings"

    private let jsonDecoder = JSONDecoder()
    private let targetHelper = TargetsHelper()
    private let settingsHelper = SettingsHelper()
    private let system: System

    init(system: System) {
        self.system = system
    }

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetHelper.commonTargets(first, second, parameters: parameters)
        let commonConfigurations = targetHelper
            .commonConfigurations(first, second)
            .filter(by: parameters.configurations)
        return try commonTargets.flatMap { firstTarget, secondTarget -> [CompareResult] in
            try commonConfigurations.map { configurationName in
                try compare((firstTarget, first),
                            (secondTarget, second),
                            configurationName: configurationName,
                            parentContext: ["\"\(firstTarget.name)\" target"])
            }
        }
    }

    // MARK: - Private

    private func compare(_ first: TargetProjectTuple,
                         _ second: TargetProjectTuple,
                         configurationName: String,
                         parentContext: [String]) throws -> CompareResult {
        let context = parentContext + ["\"\(configurationName)\" configuration"]
        let firstBuildSettings = try buildSettings(path: first.projectDescriptor.path.string,
                                                   target: first.target.name,
                                                   configuration: configurationName)
        let secondBuildSettings = try buildSettings(path: second.projectDescriptor.path.string,
                                                    target: second.target.name,
                                                    configuration: configurationName)
        return try settingsHelper.compareSettingsValues(tag: tag,
                                                        parentContext: context,
                                                        firstBuildSettings,
                                                        secondBuildSettings)
    }

    private func buildSettings(path: String, target: String, configuration: String) throws -> [String: String] {
        let command = extractBuildSettingsCommand(path: path, target: target, config: configuration)
        let output = try system.execute(arguments: command)
        do {
            return try parseRawJsonBuildSettings(output: output)
        } catch {
            throw ComparatorError.generic(
                "Cannot extract build settings from the project, invalid json output of xcodebuild command " +
                    "(project = \(path), target = \(target), configuration = \(configuration))")
        }
    }

    private func extractBuildSettingsCommand(path: String, target: String? = nil, config: String? = nil) -> [String] {
        var arguments = [
            "/usr/bin/xcrun",
            "xcodebuild",
            "-project",
            path,
        ]

        if let target = target {
            arguments.append(contentsOf: ["-target", target])
        }

        if let config = config {
            arguments.append(contentsOf: ["-config", config])
        }

        arguments.append("-showBuildSettings")
        arguments.append("-json")
        return arguments
    }

    private func parseRawJsonBuildSettings(output: String) throws -> [String: String] {
        let data = output.data(using: .utf8)!
        let result = try jsonDecoder.decode([RawShowBuildSettingsItem].self, from: data)
        var buildSettings = result[0].buildSettings
        let replacementKeys: [String] = ["PROJECT_TEMP_DIR", "PROJECT_TEMP_ROOT", "BUILD_DIR", "PROJECT_FILE_PATH"]
        let replacementValues = replacementKeys.compactMap { (key: String) -> (key: String, value: String)? in
            buildSettings[key].map { (key: key, value: $0) }
        }
        replacementValues.forEach { replacement in
            buildSettings.forEach { setting in
                buildSettings[setting.key] =
                    setting.value.replacingOccurrences(of: replacement.value, with: "$(\(replacement.key))")
            }
        }
        return buildSettings
    }
}

private struct RawShowBuildSettingsItem: Decodable {
    let buildSettings: [String: String]
}
