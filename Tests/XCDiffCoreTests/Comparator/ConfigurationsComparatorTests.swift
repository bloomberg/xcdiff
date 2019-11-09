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

final class ConfigurationsComparatorTests: XCTestCase {
    private var subject: ConfigurationsComparator!

    override func setUp() {
        subject = ConfigurationsComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, ComparatorTag.configurations)
    }

    func test_whenNoConfigurations() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: ComparatorTag.configurations, context: ["Root project"]),
        ])
    }

    func test_whenSameConfigurations() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: ComparatorTag.configurations, context: ["Root project"]),
        ])
    }

    func test_whenMissingConfigurationInFirst() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: ComparatorTag.configurations, context: ["Root project"], onlyInFirst: ["Release"]),
        ])
    }

    func test_whenMissingConfigurationInSecond() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: ComparatorTag.configurations, context: ["Root project"], onlyInSecond: ["Release"]),
        ])
    }

    func test_whenMissingConfigurationFiltered() throws {
        // Given
        let first = project()
            .addBuildConfiguration(name: "Debug")
            .projectDescriptor()
        let second = project()
            .addBuildConfiguration(name: "Debug")
            .addBuildConfiguration(name: "Release")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second,
                                         parameters: .init(targets: .all, configurations: .only("Debug")))

        // Then
        XCTAssertEqual(actual, [
            .init(tag: ComparatorTag.configurations, context: ["Root project"]),
        ])
    }
}
