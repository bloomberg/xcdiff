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

final class StringExtensionsTests: XCTestCase {
    func testSplit_whenEmptyString() {
        // Given
        let testString = ""

        // Then
        assertEqual(testString.split(around: "::"), ("", nil))
    }

    func testSplit_whenStringNotContainDelimiter() {
        // Given
        let testString = "foo"

        // Then
        assertEqual(testString.split(around: "::"), ("foo", nil))
    }

    func testSplit_whenStringHasDelimiterEnding() {
        // Given
        let testString = "foo::"

        // Then
        assertEqual(testString.split(around: "::"), ("foo", ""))
    }

    func testSplit_whenStringHasStartingDelimiter() {
        // Given
        let testString = "::bar"

        // Then
        assertEqual(testString.split(around: "::"), ("", "bar"))
    }

    func testSplit_whenStringHasMidDelimiter() {
        // Given
        let testString = "foo::bar"

        // Then
        assertEqual(testString.split(around: "::"), ("foo", "bar"))
    }

    // MARK: - Private

    private func assertEqual(_ actual: (String, String?),
                             _ expected: (String, String?),
                             file: StaticString = #file,
                             line: UInt = #line) {
        XCTAssertEqual(actual.0, expected.0, file: file, line: line)
        XCTAssertEqual(actual.1, expected.1, file: file, line: line)
    }
}
