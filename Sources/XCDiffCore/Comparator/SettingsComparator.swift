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
import PathKit
import XcodeProj

final class SettingsComparator: Comparator {
    let tag = Comparators.Tags.settings

    private let targetHelper = TargetsHelper()
    private let settingsHelper = SettingsHelper()
    private let pathHelper = PathHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let projectResult = try createProjectRawSettingsResult(first,
                                                               second,
                                                               parameters: parameters)

        let targetsResult = try createTargetRawSettingsResult(first,
                                                              second,
                                                              parameters: parameters)

        return projectResult + targetsResult
    }

    // MARK: - Private

    private func createTargetRawSettingsResult(_ first: ProjectDescriptor,
                                               _ second: ProjectDescriptor,
                                               parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetHelper.commonTargets(first, second, parameters: parameters)
        let commonConfigurations = targetHelper
            .commonConfigurations(first, second)
            .filter(by: parameters.configurations)
        return try commonTargets.flatMap { firstTarget, secondTarget -> [CompareResult] in
            try commonConfigurations.flatMap { configurationName in
                try compare(firstTarget.buildConfigurationList,
                            secondTarget.buildConfigurationList,
                            firstSourceRoot: first.sourceRoot,
                            secondSourceRoot: second.sourceRoot,
                            configurationName: configurationName,
                            parentContext: ["\"\(firstTarget.name)\" target"])
            }
        }
    }

    private func createProjectRawSettingsResult(_ first: ProjectDescriptor,
                                                _ second: ProjectDescriptor,
                                                parameters: ComparatorParameters) throws -> [CompareResult] {
        guard let firstRootProject = try first.pbxproj.rootProject() else {
            return []
        }
        guard let secondRootProject = try second.pbxproj.rootProject() else {
            return []
        }

        let commonConfigurations = targetHelper
            .commonConfigurations(first, second)
            .filter(by: parameters.configurations)
        return try commonConfigurations.flatMap { configurationName in
            try compare(firstRootProject.buildConfigurationList,
                        secondRootProject.buildConfigurationList,
                        firstSourceRoot: first.sourceRoot,
                        secondSourceRoot: second.sourceRoot,
                        configurationName: configurationName,
                        parentContext: ["Root project"])
        }
    }

    // swiftlint:disable:next function_parameter_count
    private func compare(_ first: XCConfigurationList?,
                         _ second: XCConfigurationList?,
                         firstSourceRoot: Path,
                         secondSourceRoot: Path,
                         configurationName: String,
                         parentContext: [String]) throws -> [CompareResult] {
        let context = parentContext + ["\"\(configurationName)\" configuration"]
        switch (first, second) {
        case (nil, nil):
            return [CompareResult(tag: tag, context: context)]
        case (_, nil):
            return results(context: context,
                           onlyInFirst: ["\"\(configurationName)\" configuration"])
        case (nil, _):
            return results(context: context,
                           onlyInSecond: ["\"\(configurationName)\" configuration"])
        default:
            guard let firstConfiguration = first?.configuration(name: configurationName) else {
                throw ComparatorError.generic("Configuration not found")
            }
            guard let secondConfiguration = second?.configuration(name: configurationName) else {
                throw ComparatorError.generic("Configuration not found")
            }
            let baseConfigurations = try compareBaseConfigurations(parentContext: context,
                                                                   firstConfiguration, secondConfiguration,
                                                                   firstSourceRoot: firstSourceRoot,
                                                                   secondSourceRoot: secondSourceRoot)
            let settingsValues = try compareSettingsValues(parentContext: context,
                                                           firstConfiguration, secondConfiguration)
            return [baseConfigurations, settingsValues]
        }
    }

    private func compareSettingsValues(parentContext: [String],
                                       _ first: XCBuildConfiguration,
                                       _ second: XCBuildConfiguration) throws -> CompareResult {
        return try settingsHelper.compareSettingsValues(tag: tag,
                                                        parentContext: parentContext,
                                                        first.buildSettings,
                                                        second.buildSettings)
    }

    private func compareBaseConfigurations(parentContext: [String],
                                           _ first: XCBuildConfiguration,
                                           _ second: XCBuildConfiguration,
                                           firstSourceRoot: Path,
                                           secondSourceRoot: Path) throws -> CompareResult {
        let context = parentContext + ["Base configuration"]
        let firstBaseConfiguration = try baseConfigurationAsString(from: first, sourceRoot: firstSourceRoot)
        let secondBaseConfiguration = try baseConfigurationAsString(from: second, sourceRoot: secondSourceRoot)
        guard firstBaseConfiguration == secondBaseConfiguration else {
            return result(context: context,
                          differentValues: [.init(context: "Path to .xcconfig",
                                                  first: firstBaseConfiguration,
                                                  second: secondBaseConfiguration)])
        }
        return result(context: context)
    }

    private func baseConfigurationAsString(from buildConfiguration: XCBuildConfiguration,
                                           sourceRoot: Path) throws -> String? {
        guard let baseConfiguration = buildConfiguration.baseConfiguration else {
            return nil
        }
        if let fullPath = try pathHelper.fullPath(from: baseConfiguration, sourceRoot: sourceRoot) {
            return fullPath
        }
        if let path = baseConfiguration.path {
            return path
        }

        // This error shouldn't really happen, that would suggest a broken Xcode project
        throw ComparatorError.generic("XCBuildConfiguration has an invalid base configuration")
    }
}
