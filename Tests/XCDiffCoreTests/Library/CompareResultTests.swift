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

final class CompareResultTests: XCTestCase {
    func testSame_whenEmptyArrays_true() {
        // Given
        let sut = compareResult(onlyInFirst: [], onlyInSecond: [], differentValues: [])

        // When / Then
        XCTAssertTrue(sut.same())
    }

    func testSame_whenEmpty_true() {
        // Given
        let sut = compareResult(onlyInFirst: [], onlyInSecond: [], differentValues: [])

        // When / Then
        XCTAssertTrue(sut.same())
    }

    func testSame_whenOnlyInFirst_false() {
        // Given
        let sut = compareResult(onlyInFirst: ["A"], onlyInSecond: [], differentValues: [])

        // When / Then
        XCTAssertFalse(sut.same())
    }

    func testSame_whenOnlyInSecond_false() {
        // Given
        let sut = compareResult(onlyInFirst: [], onlyInSecond: ["A"], differentValues: [])

        // When / Then
        XCTAssertFalse(sut.same())
    }

    func testSame_whenOnlyDifferentValues_false() {
        // Given
        let differentValues = self.differentValues(context: "context", first: "A", second: "B")
        let sut = compareResult(onlyInFirst: [], onlyInSecond: [], differentValues: [differentValues])

        // When / Then
        XCTAssertFalse(sut.same())
    }

    func testEqual_whenSameObject_true() {
        // Given
        let differentValues = self.differentValues(context: "context", first: "A", second: "B")
        let first = compareResult(onlyInFirst: ["A"], onlyInSecond: ["B"], differentValues: [differentValues])
        let second = first

        // When / Then
        XCTAssertEqual(first, second)
    }

    func testEqual_whenDifferentTag_false() {
        // Given
        let first = compareResult(tag: "A")
        let second = compareResult(tag: "B")

        // When / Then
        XCTAssertNotEqual(first, second)
    }

    func testEqual_whenDifferentContext_false() {
        // Given
        let first = compareResult(context: ["A"])
        let second = compareResult(context: ["B"])

        // When / Then
        XCTAssertNotEqual(first, second)
    }

    func testEqual_whenDifferentDescription_false() {
        // Given
        let first = compareResult(description: "A")
        let second = compareResult(description: nil)

        // When / Then
        XCTAssertNotEqual(first, second)
    }

    // MARK: - Private

    private func differentValues(context: String,
                                 first: String? = nil,
                                 second: String? = nil) -> CompareResult.DifferentValues {
        return CompareResult.DifferentValues(context: context, first: first, second: second)
    }

    private func compareResult(tag: ComparatorTag = "tag",
                               context: [String] = ["context", "nexted"],
                               description: String? = nil,
                               onlyInFirst: [String] = [],
                               onlyInSecond: [String] = [],
                               differentValues: [CompareResult.DifferentValues] = []) -> CompareResult {
        return CompareResult(tag: tag,
                             context: context,
                             description: description,
                             onlyInFirst: onlyInFirst,
                             onlyInSecond: onlyInSecond,
                             differentValues: differentValues)
    }
}
