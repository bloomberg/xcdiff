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

final class SourceTreesComparatorTests: XCTestCase {
    private var subject: SourceTreesComparator!

    override func setUp() {
        subject = SourceTreesComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, Comparators.Tags.sourceTrees)
    }

    func testCompare_whenHaveNoTargetsAndNoFiles() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.sourceTrees,
                  context: ["Root project"],
                  description: "Output format: (<path>, <name>, <source_tree>)"),
        ])
    }

    func testCompare_whenSameFiles() throws {
        // Given
        let first = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.sourceTrees,
                  context: ["Root project"],
                  description: "Output format: (<path>, <name>, <source_tree>)"),
        ])
    }

    func testCompare_whenDifferentPath() throws {
        // Given
        let first = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2_NEW.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.sourceTrees,
                  context: ["Root project"],
                  description: "Output format: (<path>, <name>, <source_tree>)",
                  onlyInFirst: ["(Path2.swift, nil, <group>) → (nil, Target, <group>) → (nil, nil, nil)"],
                  onlyInSecond: ["(Path2_NEW.swift, nil, <group>) → (nil, Target, <group>) → (nil, nil, nil)"]),
        ])
    }

    func testCompare_whenDifferentName() throws {
        // Given
        let first = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1_NEW").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.sourceTrees,
                  context: ["Root project"],
                  description: "Output format: (<path>, <name>, <source_tree>)",
                  differentValues: [
                      .init(context: "Path1.swift",
                            first: "(Path1.swift, Name1, <group>) → (nil, Target, <group>) → (nil, nil, nil)",
                            second: "(Path1.swift, Name1_NEW, <group>) → (nil, Target, <group>) → (nil, nil, nil)"),
                  ]),
        ])
    }

    func testCompare_whenDifferentSourceTree() throws {
        // Given
        let first = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.group) }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget {
                $0.addBuildPhase(.sources) {
                    $0.addBuildFile { $0.setName("Name1").setPath("Path1.swift").setSourceTree(.group) }
                    $0.addBuildFile { $0.setPath("Path2.swift").setSourceTree(.absolute) }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: Comparators.Tags.sourceTrees,
                  context: ["Root project"],
                  description: "Output format: (<path>, <name>, <source_tree>)",
                  differentValues: [
                      .init(context: "Path2.swift",
                            first: "(Path2.swift, nil, <group>) → (nil, Target, <group>) → (nil, nil, nil)",
                            second: "(Path2.swift, nil, <absolute>) → (nil, Target, <group>) → (nil, nil, nil)"),
                  ]),
        ])
    }
}
