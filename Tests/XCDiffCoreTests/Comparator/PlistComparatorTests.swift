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
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = ["CFBundleVersion": "1.0", "CFBundleIdentifier": "com.test.app"]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = ["CFBundleVersion": "1.0", "CFBundleIdentifier": "com.test.app"]
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
        XCTAssertEqual(results.count, 0)
    }

    func testCompare_whenDifferentPlistContent() throws {
        // Given
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = ["CFBundleVersion": "1.0", "CFBundleIdentifier": "com.test.app"]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = ["CFBundleVersion": "2.0", "CFBundleIdentifier": "com.test.app"]
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
        XCTAssertEqual(difference.context, "Info.plist.CFBundleVersion")
        XCTAssertEqual(difference.first, "1.0")
        XCTAssertEqual(difference.second, "2.0")
    }

    func testCompare_whenPlistOnlyInFirst() throws {
        // Given
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = ["CFBundleVersion": "1.0"]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = [:]
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
        XCTAssertEqual(result.onlyInFirst, [Constants.project_1_plist_path.string])
        XCTAssertTrue(result.onlyInSecond.isEmpty)
        XCTAssertTrue(result.differentValues.isEmpty)
    }

    func testCompare_whenPlistOnlyInSecond() throws {
        // Given
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = [:]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = ["CFBundleVersion": "1.0"]
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
        XCTAssertEqual(result.onlyInSecond, [Constants.project_2_plist_path.string])
        XCTAssertTrue(result.differentValues.isEmpty)
    }

    func testCompare_whenNestedDictionaryDifferences() throws {
        // Given
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": "NO",
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": "YES",
                    ],
                ],
            ],
        ]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = [
            "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": "YES",
                "NSExceptionDomains": [
                    "example.com": [
                        "NSExceptionAllowsInsecureHTTPLoads": "NO",
                    ],
                ],
            ],
        ]
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
        XCTAssertEqual(results.count, 2)
        
        // Sort results by context to make assertions predictable
        let sortedResults = results.sorted { $0.differentValues.first?.context ?? "" < $1.differentValues.first?.context ?? "" }
        
        // First result: NSAllowsArbitraryLoads
        let firstResult = sortedResults[0]
        XCTAssertTrue(firstResult.onlyInFirst.isEmpty)
        XCTAssertTrue(firstResult.onlyInSecond.isEmpty)
        XCTAssertEqual(firstResult.differentValues.count, 1)
        XCTAssertEqual(firstResult.differentValues[0].context, "Info.plist.NSAppTransportSecurity.NSAllowsArbitraryLoads")
        XCTAssertEqual(firstResult.differentValues[0].first, "NO")
        XCTAssertEqual(firstResult.differentValues[0].second, "YES")

        // Second result: NSExceptionAllowsInsecureHTTPLoads
        let secondResult = sortedResults[1]
        XCTAssertTrue(secondResult.onlyInFirst.isEmpty)
        XCTAssertTrue(secondResult.onlyInSecond.isEmpty)
        XCTAssertEqual(secondResult.differentValues.count, 1)
        XCTAssertEqual(secondResult.differentValues[0].context, "Info.plist.NSAppTransportSecurity.NSExceptionDomains.example.com.NSExceptionAllowsInsecureHTTPLoads")
        XCTAssertEqual(secondResult.differentValues[0].first, "YES")
        XCTAssertEqual(secondResult.differentValues[0].second, "NO")
    }

    func testCompare_whenArrayDifferences() throws {
        // Given
        pathHelperFake.fakePlist[Constants.project_1_plist_path] = ["UIRequiredDeviceCapabilities": ["armv7", "telephony"]]
        let first = project()
            .addTarget(name: "Target1") {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setBaseConfiguration("Debug.xcconfig")
                    $0.setValue(Constants.project_1_plist_path.string, forKey: PlistDescriptor.infoPlistKey)
                }
            }
            .projectDescriptor()
        pathHelperFake.fakePlist[Constants.project_2_plist_path] = ["UIRequiredDeviceCapabilities": ["armv7", "bluetooth-le"]]
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
        XCTAssertEqual(difference.context, "Info.plist.UIRequiredDeviceCapabilities")
        XCTAssertEqual(difference.first, "telephony")
        XCTAssertEqual(difference.second, "bluetooth-le")
    }
}

// MARK: - Fakes

private extension PlistComparatorTests {
    struct Constants {
        static let project_1_plist_path = Path("/project_1/Info.plist")
        static let project_2_plist_path = Path("/project_2/Info.plist")
    }
}

private final class PathHelperFake: PathHelper {
    var fakePlist: [Path: Plist] = [:]
    
    override func readPlistFile(from path: Path) throws -> Plist {
        fakePlist[path] ?? .emptyValue
    }
}
