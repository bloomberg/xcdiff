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
import XCTest

@testable import XCDiffCore

final class PlistComparatorTests: XCTestCase {
    private var subject: PlistComparator!
    private let pathHelperFake = PathHelperFake()

    override func setUp() {
        super.setUp()
        subject = PlistComparator(
            targetsHelper: TargetsHelper(
                pathHelper: pathHelperFake
            )
        )
    }

    func testTag() {
        // Then
        XCTAssertEqual(subject.tag, "plists")
    }

    func testCompare_whenNoPlistsInEitherTarget() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 0)
    }

    func testCompare_whenSamePlistsWithSameContent() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.first, .init(tag: "plists", context: [
            Constants.project_1_plist_path.lastComponent, Constants.project_2_plist_path.lastComponent,
        ]))
    }

    func testCompare_whenDifferentPlistContent() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: [
            "CFBundleVersion": "1.0",
            "CFBundleIdentifier": "com.test.app",
        ])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: [
            "CFBundleVersion": "2.0",
            "CFBundleIdentifier": "com.test.app",
        ])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 1)
        let result = try XCTUnwrap(results.first)
        XCTAssertTrue(result.onlyInFirst.isEmpty)
        XCTAssertTrue(result.onlyInSecond.isEmpty)
        XCTAssertEqual(result.differentValues.count, 1)

        let difference = result.differentValues.first!
        XCTAssertEqual(difference.context, "CFBundleVersion")
        XCTAssertEqual(difference.first, "1.0")
        XCTAssertEqual(difference.second, "2.0")
    }

    func testCompare_whenPlistOnlyInFirst() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: ["CFBundleVersion": "1.0"])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: ["CFBundleIdentifier": "1.0"])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 1)
        let result = try XCTUnwrap(results.first)
        XCTAssertEqual(result.onlyInFirst, ["CFBundleVersion"])
        XCTAssertEqual(result.onlyInSecond, ["CFBundleIdentifier"])
        XCTAssertTrue(result.differentValues.isEmpty)
    }

    func testCompare_whenPlistOnlyInSecond() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: [:])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: ["CFBundleVersion": "1.0"])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 1)
        let result = try XCTUnwrap(results.first)
        XCTAssertTrue(result.onlyInFirst.isEmpty)
        XCTAssertEqual(result.onlyInSecond, ["CFBundleVersion"])
        XCTAssertTrue(result.differentValues.isEmpty)
    }

    // swiftlint:disable:next function_body_length
    func testCompare_whenNestedDictionaryDifferences() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": false,
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": true,
                    ],
                ],
            ],
        ])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": true,
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": false,
                    ],
                ],
            ],
        ])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()

        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        let result = try XCTUnwrap(results.first)
        let firstDiff = result.differentValues[0]
        let secondDiff = result.differentValues[1]
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(result.onlyInFirst.isEmpty)
        XCTAssertTrue(result.onlyInSecond.isEmpty)
        XCTAssertEqual(result.differentValues.count, 2)
        XCTAssertEqual(
            firstDiff.context,
            "NSAppTransportSecurity.NSAllowsArbitraryLoads"
        )
        XCTAssertEqual(firstDiff.first, "false")
        XCTAssertEqual(firstDiff.second, "true")
        XCTAssertEqual(
            secondDiff.context,
            "NSAppTransportSecurity.NSExceptionDomains.example.com.NSExceptionAllowsInsecureHTTPLoads"
        )
        XCTAssertEqual(secondDiff.first, "true")
        XCTAssertEqual(secondDiff.second, "false")
    }

    func testCompare_whenArrayDifferences() throws {
        // Given
        pathHelperFake.setPlist(for: Constants.project_1_plist_path, dictionary: [
            "UIRequiredDeviceCapabilities": ["armv7", "telephony"],
        ])
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.setPlist(for: Constants.project_2_plist_path, dictionary: [
            "UIRequiredDeviceCapabilities": ["armv7", "bluetooth-le"],
        ])
        let second = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_2_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        // When
        let results = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(results.count, 1)
        let result = try XCTUnwrap(results.first)
        XCTAssertTrue(result.onlyInFirst.isEmpty)
        XCTAssertTrue(result.onlyInSecond.isEmpty)
        XCTAssertEqual(result.differentValues.count, 1)

        let difference = result.differentValues.first!
        XCTAssertEqual(difference.context, "UIRequiredDeviceCapabilities")
        XCTAssertEqual(difference.first, "telephony")
        XCTAssertEqual(difference.second, "bluetooth-le")
    }
}

// MARK: - Fakes

private extension PlistComparatorTests {
    struct Constants {
        static let project_1_plist_path = Path("/project_1/Info.plist") // swiftlint:disable:this identifier_name
        static let project_2_plist_path = Path("/project_2/Info.plist") // swiftlint:disable:this identifier_name
    }
}

private final class PathHelperFake: PathHelper {
    var fakePlist: [Path: PlistValue] = [:]

    override func readPlistFile(from path: Path) throws -> PlistValue {
        guard let value = fakePlist[path] else { throw URLError(.badURL) }
        return value
    }

    func setPlist(for path: Path, dictionary: [String: Any]) {
        fakePlist[path] = PlistValue(from: dictionary)
    }
}
