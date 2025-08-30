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

import PathKit
import XcodeProj
import XCTest

@testable import XCDiffCore

// swiftlint:disable file_length
// swiftlint:disable type_body_length
// swiftlint:disable line_length
final class PlistComparatorTests: XCTestCase {
    private var subject: PlistComparator!
    private var firstProject: ProjectDescriptor!
    private var secondProject: ProjectDescriptor!
    private var targetsPlistHelper = FakeTargetsPlistHelper()

    override func setUp() {
        super.setUp()

        firstProject = project()
            .addTarget(name: Constants.targetName) {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(
                        Constants.project_1_plist_path.string,
                        forKey: PlistDescriptor.PlistType.info.buildSettingsKey
                    )
                }
            }
            .projectDescriptor()

        secondProject = project()
            .addTarget(name: Constants.targetName) {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(
                        Constants.project_2_plist_path.string,
                        forKey: PlistDescriptor.PlistType.info.buildSettingsKey
                    )
                }
            }
            .projectDescriptor()

        subject = PlistComparator(
            targetsHelper: TargetsHelper(
                pathHelper: PathHelper(),
                targetPlistHelper: targetsPlistHelper
            )
        )
    }

    func testTag() {
        subject = .init()
        XCTAssertEqual(subject.tag, "plists")
    }

    func testCompare_whenNoPlistsInEitherTarget() throws {
        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 0)
    }

    func testCompare_whenSamePlistsWithSameContent() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ]

        let expected = CompareResult(
            tag: "plists",
            context: [
                "\"\(Constants.targetName)\" target",
                "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
            ]
        )

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first, expected)
    }

    func testCompare_whenDifferentPlistContent() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = [
            "CFBundleVersion": "2.0",
            "CFBundleIdentifier": "com.test.app",
        ]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: [],
                onlyInSecond: [],
                differentValues: [
                    .init(
                        context: "CFBundleVersion",
                        first: "1.0",
                        second: "2.0"
                    ),
                ]
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    func testCompare_whenPlistOnlyInFirst() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = ["CFBundleVersion": "1.0"]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = ["CFBundleIdentifier": "1.0"]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: ["CFBundleVersion"],
                onlyInSecond: ["CFBundleIdentifier"],
                differentValues: []
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    func testCompare_whenPlistOnlyInSecond() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [:]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = ["CFBundleVersion": "1.0"]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: [],
                onlyInSecond: ["CFBundleVersion"],
                differentValues: []
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    func testCompare_whenNestedDictionaryDifferences() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": false,
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": true,
                    ],
                ],
            ],
        ]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": true,
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": false,
                    ],
                ],
            ],
        ]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: [],
                onlyInSecond: [],
                differentValues: [
                    .init(
                        context: "NSAppTransportSecurity.NSAllowsArbitraryLoads",
                        first: "false",
                        second: "true"
                    ),
                    .init(
                        context:
                        "NSAppTransportSecurity.NSExceptionDomains.example.com.NSExceptionAllowsInsecureHTTPLoads",
                        first: "true",
                        second: "false"
                    ),
                ]
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    func testCompare_whenArrayDifferences() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [
            "UIRequiredDeviceCapabilities": ["armv7", "telephony", "fetch"],
        ]
        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = [
            "UIRequiredDeviceCapabilities": ["bluetooth-le", "armv7"],
        ]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: ["fetch", "telephony"],
                onlyInSecond: ["bluetooth-le"],
                differentValues: [
                    .init(
                        context: "UIRequiredDeviceCapabilities[0]",
                        first: "armv7",
                        second: "bluetooth-le"
                    ),
                    .init(
                        context: "UIRequiredDeviceCapabilities[1]",
                        first: "telephony",
                        second: "armv7"
                    ),
                ]
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    // swiftlint:disable:next function_body_length
    func testCompare_whenArrayDifferenceNestedComplexStructure() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = [
            "UIApplicationSceneManifest": [
                [
                    "UIApplicationSupportsMultipleScenes_1": false,
                    "UISceneConfigurations_1": [
                        "UIWindowSceneSessionRoleApplication_1": [
                            [
                                "UISceneConfigurationName_1": "Default Configuration",
                                "UISceneDelegateClassName_1": "$(PRODUCT_MODULE_NAME).AppSceneDelegate",
                            ],
                        ],
                    ],
                ],
                [
                    "UIApplicationSupportsMultipleScenes_2": true,
                    "UISceneConfigurations_2": [
                        "UIWindowSceneSessionRoleApplication_2": [
                            [
                                "UISceneConfigurationName_2": "Default Configuration",
                                "UISceneDelegateClassName_2": "$(PRODUCT_MODULE_NAME).AppSceneDelegate",
                            ],
                        ],
                    ],
                ],
            ],
        ]

        targetsPlistHelper.infoPlist[Constants.project_2_plist_path] = [
            "UIApplicationSceneManifest": [
                [
                    "UIApplicationSupportsMultipleScenes_1": true,
                    "UISceneConfigurations_1": [
                        "UIWindowSceneSessionRoleApplication_1": [
                            [
                                "UISceneConfigurationName_1": "Debug Configuration",
                                "UISceneDelegateClassName_1": "$(PRODUCT_MODULE_NAME).AppSceneDelegate",
                                "UIScenePriority": "Perspective",
                            ],
                        ],
                    ],
                ],
                [
                    "UISceneConfigurations_2": [
                        "UIWindowSceneSessionRoleApplication_2": [
                            [
                                "UISceneConfigurationName_2": "Release Configuration",
                            ],
                        ],
                    ],
                ],
            ],
        ]

        let expected = [
            CompareResult(
                tag: "plists",
                context: [
                    "\"\(Constants.targetName)\" target",
                    "\(Constants.project_1_plist_path.lastComponent) - \(Constants.project_2_plist_path.lastComponent)",
                ],
                description: nil,
                onlyInFirst: [
                    "UIApplicationSupportsMultipleScenes_2",
                    "UISceneDelegateClassName_2",
                ],
                onlyInSecond: [
                    "UIScenePriority",
                ],
                differentValues: [
                    .init(
                        context: "UIApplicationSceneManifest[0].UIApplicationSupportsMultipleScenes_1",
                        first: "false",
                        second: "true"
                    ),
                    .init(
                        context: "UIApplicationSceneManifest[0].UISceneConfigurations_1.UIWindowSceneSessionRoleApplication_1[0].UISceneConfigurationName_1",
                        first: "Default Configuration",
                        second: "Debug Configuration"
                    ),
                    .init(
                        context: "UIApplicationSceneManifest[1].UISceneConfigurations_2.UIWindowSceneSessionRoleApplication_2[0].UISceneConfigurationName_2",
                        first: "Default Configuration",
                        second: "Release Configuration"
                    ),
                ]
            ),
        ]

        // When
        let results = try subject.compare(firstProject, secondProject, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }

    func testCompare_whenTargetHasDifferentNumberOfPlists_onlyInfoPlistVsBothInfoAndEntitlements() throws {
        // Given
        targetsPlistHelper.infoPlist[Constants.project_1_plist_path] = ["CFBundleVersion": "1.0"]
        targetsPlistHelper.entitlements[Constants.project_2_entitlements_path] = ["aps-environment": "development"]
        
        let firstProjectWithInfoOnly = project()
            .addTarget(name: Constants.targetName) {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setValue(
                        Constants.project_1_plist_path.string,
                        forKey: PlistDescriptor.PlistType.info.buildSettingsKey
                    )
                }
            }
            .projectDescriptor()

        let secondProjectWithBoth = project()
            .addTarget(name: Constants.targetName) {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setValue(
                        Constants.project_2_entitlements_path.string,
                        forKey: PlistDescriptor.PlistType.entitlements.buildSettingsKey
                    )
                }
            }
            .projectDescriptor()


        let expected = [
            CompareResult(
                tag: "plists",
                context: ["\"\(Constants.targetName)\" target"],
                description: nil,
                onlyInFirst: ["Info.plist"],
                onlyInSecond: ["Project.entitlements"],
                differentValues: []
            ),
        ]

        // When
        let results = try subject.compare(firstProjectWithInfoOnly, secondProjectWithBoth, parameters: .all)

        // Then
        XCTAssertEqual(results, expected)
    }
}

// swiftlint:enable type_body_length
// swiftlint:enable line_length

// MARK: - Fakes

private extension PlistComparatorTests {
    struct Constants {
        // swiftlint:disable identifier_name
        static let targetName = "TargetName"
        static let project_1_plist_path = Path("/project_1/Info.plist")
        static let project_2_plist_path = Path("/project_2/Info.plist")
        static let project_1_entitlements_path = Path("/project_1/Project.entitlements")
        static let project_2_entitlements_path = Path("/project_2/Project.entitlements")
        // swiftlint:enable identifier_name
    }
}

private final class FakeTargetsPlistHelper: TargetsPlistHelperProtocol {
    var infoPlist: [Path: Any] = [:]
    var entitlements: [Path: Any] = [:]

    func infoPlist(target: PBXTarget, sourceRoot _: Path) throws -> PlistDescriptor {
        let buildConfig = target.buildConfigurationList?.buildConfigurations.first
        let plistType = PlistDescriptor.PlistType.info
        let plistPathString = buildConfig?.buildSettings[plistType.buildSettingsKey] as? String ?? ""

        guard let anyValue = infoPlist[Path(plistPathString)] else { throw URLError(.badURL) }

        return .init(
            target: target.name,
            path: Path(plistPathString),
            plistValue: PlistValue(from: anyValue),
            type: .info
        )
    }

    func entitlementsPlist(target: PBXTarget, sourceRoot _: Path) throws -> PlistDescriptor {
        let buildConfig = target.buildConfigurationList?.buildConfigurations.first
        let plistType = PlistDescriptor.PlistType.entitlements
        let plistPathString = buildConfig?.buildSettings[plistType.buildSettingsKey] as? String ?? ""

        guard let anyValue = entitlements[Path(plistPathString)] else { throw URLError(.badURL) }

        return .init(
            target: target.name,
            path: Path(plistPathString),
            plistValue: PlistValue(from: anyValue),
            type: .entitlements
        )
    }
}
