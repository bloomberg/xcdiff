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
@testable import XCDiffCore
import XCTest

// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
final class ResolvedSettingsComparatorTests: XCTestCase {
    private var subject: ResolvedSettingsComparator!
    private var system: SystemMock!

    override func setUp() {
        super.setUp()

        system = SystemMock()
        subject = ResolvedSettingsComparator(system: system)
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, "resolved_settings")
    }

    // swiftlint:disable:next function_body_length
    func testCompare_whenNoDifference() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(system.executeCalls, [
            ["/usr/bin/xcrun", "xcodebuild",
             "-project", "/projectDirPath",
             "-target", "Target1",
             "-config", "Debug",
             "-showBuildSettings",
             "-json"],
            ["/usr/bin/xcrun", "xcodebuild",
             "-project", "/projectDirPath",
             "-target", "Target1",
             "-config", "Debug",
             "-showBuildSettings",
             "-json"],
        ])
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"]),
        ])
    }

    func testCompare_whenConfigurationOnlyInFirst() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        // No result as there is no common build configuration
        XCTAssertEqual(actual, [])
    }

    func testCompare_whenConfigurationOnlyInSecond() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addTarget(name: "Target1")
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [])
    }

    func testCompare_whenSettingsOnlyInFirst() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"],
                  onlyInFirst: ["TARGETED_DEVICE_FAMILY = 1,2", "TARGETNAME = Target1"]),
        ])
    }

    func testCompare_whenSettingsOnlyInSecond() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "TARGETNAME": "Target1",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"],
                  onlyInSecond: ["TARGETED_DEVICE_FAMILY = 1,2", "TARGETNAME = Target1"]),
        ])
    }

    func testCompare_whenDifferentSettings() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TARGETED_DEVICE_FAMILY": "1,2",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TARGETED_DEVICE_FAMILY": "1",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"],
                  differentValues: [
                      .init(context: "TARGETED_DEVICE_FAMILY", first: "1,2", second: "1"),
                  ]),
        ])
    }

    func testCompare_whenDifferentSettingsWithEqualsSign() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "Target1")
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addTarget(name: "Target1")
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1",
                        "CUSTOM": "VALUE=1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "TAPI_VERIFY_MODE": "ErrorsOnly",
                        "PROJECT_NAME": "P1_NEW",
                        "CUSTOM": "VALUE=2"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"],
                  differentValues: [
                      .init(context: "CUSTOM", first: "VALUE=1", second: "VALUE=2"),
                  ]),
        ])
    }

    func testCompare_whenDifferentSettingsDueToProjectName() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "PROJECT_FILE_PATH": "/Projects/Folder/P1.xcodeproj",
                        "PROJECT_NAME": "P1"
                    }
                }
            ]
            """,
            """
            [
                {
                    "action" : "build",
                    "buildSettings" : {
                        "PROJECT_FILE_PATH": "/Projects/Folder/P1_NEW.xcodeproj",
                        "PROJECT_NAME": "P1_NEW"
                    }
                }
            ]
            """,
        ]

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "resolved_settings",
                  context: ["\"Target1\" target", "\"Debug\" configuration", "Values"]),
        ])
    }

    func testCompare_whenInvalidJson() throws {
        // Given
        let first = project(name: "P1")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project(name: "P1_NEW")
            .addBuildConfiguration(name: "Debug")
            .addTarget(name: "Target1")
            .projectDescriptor()

        system.mockExecuteResults = [
            """
            invalid json
            """,
            """
            []
            """,
        ]

        // When / Then
        XCTAssertThrowsError(try subject.compare(first, second, parameters: .all)) { error in
            XCTAssertEqual(error.localizedDescription,
                           "Cannot extract build settings from the project, invalid json output of xcodebuild " +
                               "command (project = /projectDirPath, target = Target1, configuration = Debug)")
        }
    }
}
