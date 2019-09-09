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

final class SuffixStringDiffTests: XCTestCase {
    private var subject: SuffixStringDiff!

    override func setUp() {
        super.setUp()

        subject = SuffixStringDiff()
    }

    func testDiff_whenSameSingleCharacter() {
        // When / Then
        XCTAssertEqual("", subject.diff("A", "A"))
        XCTAssertEqual("", subject.diff("a", "a"))
        XCTAssertEqual("", subject.diff("1", "1"))
    }

    func testDiff_whenSameMulitpleCharacters() {
        // When / Then
        XCTAssertEqual("", subject.diff("AAA", "AAA"))
        XCTAssertEqual("", subject.diff("ABC", "ABC"))
        XCTAssertEqual("", subject.diff("abc", "abc"))
        XCTAssertEqual("", subject.diff("111", "111"))
        XCTAssertEqual("", subject.diff("123", "123"))
        XCTAssertEqual("", subject.diff("abc123", "abc123"))
    }

    func testDiff_whenDifferentSingleCharacter() {
        // When / Then
        XCTAssertEqual("BA", subject.diff("A", "B"))
        XCTAssertEqual("Ba", subject.diff("a", "B"))
        XCTAssertEqual("21", subject.diff("1", "2"))
    }

    func testDiff_whenDifferentMultipleCharacter() {
        // When / Then
        XCTAssertEqual("CDBC", subject.diff("ABC", "ACD"))
        XCTAssertEqual("BD", subject.diff("ACD", "ABC"))
        XCTAssertEqual("BCDabc", subject.diff("abc", "BCD"))
        XCTAssertEqual("234123", subject.diff("123", "234"))
    }

    func testDiff_whenSuffix() {
        // When / Then
        XCTAssertEqual("DE", subject.diff("ABC", "ABCDE"))
        XCTAssertEqual("DE", subject.diff("ABCDE", "ABC"))
    }
}
