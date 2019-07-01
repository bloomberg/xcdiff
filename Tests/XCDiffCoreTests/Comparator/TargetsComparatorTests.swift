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

final class TargetsComparatorTests: XCTestCase {
    private var sut: TargetsComparator!

    override func setUp() {
        super.setUp()

        sut = TargetsComparator()
    }

    func testCompare_whenHaveNoTargets() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .none)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: "targets", context: ["Native"]),
            CompareResult(tag: "targets", context: ["Aggregate"]),
        ])
    }

    func testCompare_whenHaveSameTargets() throws {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "C"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A", "B", "C"])
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .none)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: "targets", context: ["Native"]),
            CompareResult(tag: "targets", context: ["Aggregate"]),
        ])
    }

    func testCompare_whenHaveDifferentTargets() throws {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "C_UPDATED", "D_NEW"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A_UPDATED", "B", "C", "E_NEW"])
            .addAggregateTarget(name: "NEW_AGGREGATE")
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .none)

        // Then
        let expected = [
            CompareResult(tag: "targets",
                          context: ["Native"],
                          onlyInFirst: ["A", "C_UPDATED", "D_NEW"],
                          onlyInSecond: ["A_UPDATED", "C", "E_NEW"]),
            CompareResult(tag: "targets",
                          context: ["Aggregate"],
                          onlyInSecond: ["NEW_AGGREGATE"]),
        ]
        XCTAssertEqual(actual, expected)
    }
}
