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
// swiftlint:disable type_body_length
final class SettingsComparatorTests: XCTestCase {
    private var subject: SettingsComparator!

    override func setUp() {
        super.setUp()

        subject = SettingsComparator()
    }

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, Comparators.Tags.settings)
    }

    func testCompare_whenNoSettings_noDifference() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [])
    }

    func testCompare_whenSameProjectSettings_noDifference() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release") {
                $0.setBaseConfiguration("BaseRelease.xcconfig")
                $0.setValue("A_VALUE", forKey: "A")
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release") {
                $0.setBaseConfiguration("BaseRelease.xcconfig")
                $0.setValue("A_VALUE", forKey: "A")
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"]),
        ])
    }

    func testCompare_whenDifferentProjectBaseConfigurations() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release") {
                $0.setBaseConfiguration("BaseRelease.xcconfig")
                $0.setValue("A_VALUE", forKey: "A")
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release") {
                $0.setBaseConfiguration("BaseRelease_NEW.xcconfig")
                $0.setValue("A_VALUE", forKey: "A")
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"],
                  differentValues: [
                      .init(context: "Path to .xcconfig",
                            first: "BaseRelease.xcconfig",
                            second: "BaseRelease_NEW.xcconfig"),
                  ]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"]),
        ])
    }

    func testCompare_whenDifferentProjectSettingValues() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release") {
                $0.setValue("A_VALUE_1", forKey: "A") // different value
                $0.setValue("B_VALUE", forKey: "B") // only in first
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release") {
                $0.setValue("A_VALUE_2", forKey: "A") // different value
                $0.setValue("C_VALUE", forKey: "C") // only in second
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"],
                  onlyInFirst: ["B"],
                  onlyInSecond: ["C"],
                  differentValues: [.init(context: "A", first: "A_VALUE_1", second: "A_VALUE_2")]),
        ])
    }

    func testCompare_whenTargetSettings_noDifference() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setBaseConfiguration("BaseRelease.xcconfig")
                    $0.setValue("A_VALUE", forKey: "A")
                }
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setBaseConfiguration("BaseRelease.xcconfig")
                    $0.setValue("A_VALUE", forKey: "A")
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Values"]),
        ])
    }

    func testCompare_whenDifferentTargetBaseConfigurations() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setBaseConfiguration("BaseRelease.xcconfig")
                    $0.setValue("A_VALUE", forKey: "A")
                }
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setBaseConfiguration("BaseRelease_NEW.xcconfig")
                    $0.setValue("A_VALUE", forKey: "A")
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Base configuration"],
                  differentValues: [
                      .init(context: "Path to .xcconfig",
                            first: "BaseRelease.xcconfig",
                            second: "BaseRelease_NEW.xcconfig"),
                  ]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Values"]),
        ])
    }

    func testCompare_whenDifferentTargetSettingValues() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_1", forKey: "A") // different value
                    $0.setValue("B_VALUE", forKey: "B") // only in first
                }
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_2", forKey: "A") // different value
                    $0.setValue("C_VALUE", forKey: "C") // only in second
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Release\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Release\" configuration", "Values"],
                  onlyInFirst: ["B"],
                  onlyInSecond: ["C"],
                  differentValues: [.init(context: "A", first: "A_VALUE_1", second: "A_VALUE_2")]),
        ])
    }

    func testCompare_whenNonExistingConfigurationFilter_noDifference() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_1", forKey: "A") // different value
                    $0.setValue("B_VALUE", forKey: "B") // only in first
                }
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_2", forKey: "A") // different value
                    $0.setValue("C_VALUE", forKey: "C") // only in second
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .init(targets: .all,
                                                                          configurations: .only("NON_EXISTING")))

        // Then
        XCTAssertEqual(actual, [])
    }

    func testCompare_whenExistingConfigurationFilter() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setValue("A_VALUE_1", forKey: "DEBUG_A") // different value
                    $0.setValue("B_VALUE", forKey: "DEBUG_B") // only in first
                }
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_1", forKey: "RELEASE_A") // different value
                    $0.setValue("B_VALUE", forKey: "RELEASE_B") // only in first
                }
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .addTarget {
                $0.addBuildConfiguration(name: "Debug") {
                    $0.setValue("A_VALUE_2", forKey: "DEBUG_A") // different value
                    $0.setValue("C_VALUE", forKey: "DEBUG_C") // only in second
                }
                $0.addBuildConfiguration(name: "Release") {
                    $0.setValue("A_VALUE_2", forKey: "RELEASE_A") // different value
                    $0.setValue("C_VALUE", forKey: "RELEASE_C") // only in second
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .init(targets: .all,
                                                                          configurations: .only("Debug")))

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Debug\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Debug\" configuration", "Values"],
                  onlyInFirst: ["DEBUG_B"],
                  onlyInSecond: ["DEBUG_C"],
                  differentValues: [.init(context: "DEBUG_A", first: "A_VALUE_1", second: "A_VALUE_2")]),
        ])
    }

    func testCompare_whenFirstTargetMissingConfiguration() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget()
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget {
                $0.addBuildConfiguration(name: "Debug")
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Debug\" configuration"],
                  onlyInSecond: ["\"Debug\" configuration"]),
        ])
    }

    func testCompare_whenSecondTargetMissingConfiguration() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget {
                $0.addBuildConfiguration(name: "Debug")
            }
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget()
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Debug\" configuration"],
                  onlyInFirst: ["\"Debug\" configuration"]),
        ])
    }

    func testCompare_whenFirstAndSecondTargetsMissingConfiguration() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget()
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addTarget()
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Base configuration"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["Root project", "\"Debug\" configuration", "Values"]),
            .init(tag: Comparators.Tags.settings,
                  context: ["\"Target\" target", "\"Debug\" configuration"]),
        ])
    }
}

// swiftlint:enable type_body_length
