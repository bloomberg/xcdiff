//
// Copyright 2020 Bloomberg Finance L.P.
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

// swiftlint:disable file_length

import Foundation
@testable import XCDiffCore
import XCTest

// swiftlint:disable:next type_body_length
final class AttributesComparatorTests: XCTestCase {
    private var subject: AttributesComparator!

    override func setUp() {
        subject = AttributesComparator()
    }

    // MARK: - Project Attributes

    func testCompare_whenNoAttributes() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
        ])
    }

    func testCompare_whenSameAttributes() throws {
        // Given
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "LastUpgradeCheck", value: "1030")
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "LastUpgradeCheck", value: "1030")
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
        ])
    }

    func testCompare_whenDictionaryAttributes() throws {
        // Given
        let dictionary1 = [
            "test.attribute1": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute3": ["enabled": "1"],
        ]
        let dictionary2 = [
            "test.attribute3": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute1": ["enabled": "1"],
        ]
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "ComplexAttributes", value: dictionary1)
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "ComplexAttributes", value: dictionary2)
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
        ])
    }

    func testCompare_whenDifferentDictionaryAttributes() throws {
        // Given
        let dictionary1 = [
            "test.attribute1": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute3": ["enabled": "0"],
        ]
        let dictionary2 = [
            "test.attribute3": ["enabled": "1"],
            "test.attribute2": ["enabled": "0"],
            "test.attribute1": ["enabled": "1"],
        ]
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "ComplexAttributes", value: dictionary1)
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "ComplexAttributes", value: dictionary2)
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"],
                differentValues: [
                    .init(
                        context: "ComplexAttributes",
                        first: "[\"test.attribute1\": [\"enabled\": \"1\"], " +
                            "\"test.attribute2\": [\"enabled\": \"1\"], " +
                            "\"test.attribute3\": [\"enabled\": \"0\"]]",
                        second: "[\"test.attribute1\": [\"enabled\": \"1\"], " +
                            "\"test.attribute2\": [\"enabled\": \"0\"], " +
                            "\"test.attribute3\": [\"enabled\": \"1\"]]"
                    ),
                ]
            ),
        ])
    }

    func testCompare_whenAttributeOnlyInFirst() throws {
        // Given
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "LastUpgradeCheck", value: "1030")
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"],
                onlyInFirst: ["LastUpgradeCheck = 1030"]
            ),
        ])
    }

    func testCompare_whenAttributeOnlyInSecond() throws {
        // Given
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1110")
            .addAttribute(name: "LastUpgradeCheck", value: "1030")
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"],
                onlyInSecond: ["LastUpgradeCheck = 1030"]
            ),
        ])
    }

    func testCompare_whenDifferentAttributeValues() throws {
        // Given
        let first = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1030")
            .addAttribute(name: "LastUpgradeCheck", value: "1030")
            .projectDescriptor()
        let second = project()
            .addAttribute(name: "LastSwiftUpdateCheck", value: "1220")
            .addAttribute(name: "LastUpgradeCheck", value: "1220")
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"],
                differentValues: [
                    .init(context: "LastSwiftUpdateCheck", first: "1030", second: "1220"),
                    .init(context: "LastUpgradeCheck", first: "1030", second: "1220"),
                ]
            ),
        ])
    }

    // MARK: - Target Attributes

    func testCompare_targetAttributes_whenNoAttributes() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application)
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application)
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"]
            ),
        ])
    }

    func testCompare_targetAttributes_whenSameAttributes() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"]
            ),
        ])
    }

    func testCompare_targetAttributes_whenDictionaryAttributes() throws {
        // Given
        let dictionary1 = [
            "test.attribute1": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute3": ["enabled": "1"],
        ]
        let dictionary2 = [
            "test.attribute3": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute1": ["enabled": "1"],
        ]
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "ComplexAttributes", value: dictionary1)
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "ComplexAttributes", value: dictionary2)
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"]
            ),
        ])
    }

    func testCompare_targetAttributes_whenDifferentDictionaryAttributes() throws {
        // Given
        let dictionary1 = [
            "test.attribute1": ["enabled": "1"],
            "test.attribute2": ["enabled": "1"],
            "test.attribute3": ["enabled": "0"],
        ]
        let dictionary2 = [
            "test.attribute3": ["enabled": "1"],
            "test.attribute2": ["enabled": "0"],
            "test.attribute1": ["enabled": "1"],
        ]
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "ComplexAttributes", value: dictionary1)
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "ComplexAttributes", value: dictionary2)
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"],
                differentValues: [
                    .init(
                        context: "ComplexAttributes",
                        first: "[\"test.attribute1\": [\"enabled\": \"1\"], " +
                            "\"test.attribute2\": [\"enabled\": \"1\"], " +
                            "\"test.attribute3\": [\"enabled\": \"0\"]]",
                        second: "[\"test.attribute1\": [\"enabled\": \"1\"], " +
                            "\"test.attribute2\": [\"enabled\": \"0\"], " +
                            "\"test.attribute3\": [\"enabled\": \"1\"]]"
                    ),
                ]
            ),
        ])
    }

    func testCompare_targetAttributes_whenAttributeOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"],
                onlyInFirst: ["LastSwiftMigration = 1250"]
            ),
        ])
    }

    func testCompare_targetAttributes_whenAttributeOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"],
                onlyInSecond: ["LastSwiftMigration = 1250"]
            ),
        ])
    }

    func testCompare_targetAttributes_whenDifferentAttributeValues() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1300")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.5")
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application) { builder in
                builder.addAttribute(name: "LastSwiftMigration", value: "1250")
                builder.addAttribute(name: "CreatedOnToolsVersion", value: "12.0")
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"],
                differentValues: [
                    .init(context: "CreatedOnToolsVersion", first: "12.5", second: "12.0"),
                    .init(context: "LastSwiftMigration", first: "1300", second: "1250"),
                ]
            ),
        ])
    }

    func testCompare_targetAttributes_whenTargetReferencesSameTargetWithDifferentIds() throws {
        // Given
        let first = project()
            .addTarget(name: "TargetA", productType: .application)
            .addTarget(name: "TargetB", productType: .application) { builder in
                builder.addAttribute(name: "TestTargetID", referenceTarget: "TargetA")
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "TargetA", productType: .application)
            .addTarget(name: "TargetB", productType: .application) { builder in
                builder.addAttribute(name: "TestTargetID", referenceTarget: "TargetA")
            }
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "attributes",
                context: ["Root project"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetA\" target"]
            ),
            .init(
                tag: "attributes",
                context: ["\"TargetB\" target"]
            ),
        ])
    }
}
