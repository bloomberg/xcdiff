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

@testable import XCDiffCore
import XCTest

final class HeadersComparatorTests: XCTestCase {
    private var subject: HeadersComparator!

    override func setUp() {
        subject = HeadersComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, "headers")
    }

    func testCompare_whenNoHeaders_noDifference() throws {
        // Given
        let first = project()
            .addTargets(names: ["A"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A"])
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["A"]))
    }

    func testCompare_whenSameHeaders_noDifference() throws {
        // Given
        let first = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A.h", .public), ("B.h", .private), ("C.h", nil)])
            }
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A.h", .public), ("B.h", .private), ("C.h", nil)])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["A"]))
    }

    func testCompare_whenDifferentPublicHeaders() throws {
        // Given
        let first = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A1.h", .public), ("B.h", .private), ("C.h", nil)])
            }
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A2.h", .public), ("B.h", .private), ("C.h", nil)])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "headers",
                                              context: ["\"A\" target"],
                                              description: nil,
                                              onlyInFirst: ["A1.h"],
                                              onlyInSecond: ["A2.h"],
                                              differentValues: [])])
    }

    func testCompare_whenSameFilesButDifferentAccessLevels() throws {
        // Given
        let first = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A.h", .public), ("B.h", .private), ("C.h", nil), ("D.h", .private)])
            }
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A"]) {
                $0.addHeaders([("A.h", .private), ("B.h", .private), ("C.h", .private), ("D.h", nil)])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        let expected = [CompareResult(tag: "headers",
                                      context: ["\"A\" target"],
                                      description: nil,
                                      onlyInFirst: [],
                                      onlyInSecond: [],
                                      differentValues: [
                                          .init(context: "A.h attributes",
                                                first: "Public",
                                                second: "Private"),
                                          .init(context: "C.h attributes",
                                                first: "Project",
                                                second: "Private"),
                                          .init(context: "D.h attributes",
                                                first: "Private",
                                                second: "Project"),
                                      ])]
        XCTAssertEqual(actual, expected)
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        return targets.map {
            CompareResult(tag: "headers",
                          context: ["\"\($0)\" target"],
                          description: nil,
                          onlyInFirst: [],
                          onlyInSecond: [],
                          differentValues: [])
        }
    }
}
