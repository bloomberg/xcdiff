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
    private var delimiter: String!

    override func setUp() {
        super.setUp()

        delimiter = "::"
    }

    func test_split_empty_string() {
        //Given
        let testString = ""

        //Then
        equal(testString.split(around: delimiter), ("", nil))
    }

    func test_split_string_not_contain_delimiter() {
        //Given
        let testString = "foo"

        //Then
        equal(testString.split(around: delimiter), ("foo", nil))
    }

    func test_split_string_has_delimiter_end() {
        //Given
        let testString = "foo::"

        //Then
        equal(testString.split(around: delimiter), ("foo", ""))
    }

    func test_split_string_starting_delimiter() {
        //Given
        let testString = "::bar"

        //Then
        equal(testString.split(around: delimiter), ("", "bar"))
    }

    func test_split_string_mid_delimiter() {
        //Given
        let testString = "foo::bar"

        //Then
        equal(testString.split(around: delimiter), ("foo", "bar"))
    }

    func equal(_ lhs: (String, String?), _ rhs: (String, String?), file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(lhs.0, rhs.0, file: file, line: line)
        XCTAssertEqual(lhs.1, rhs.1, file: file, line: line)
    }
}
