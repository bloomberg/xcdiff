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

final class StringOutputBufferTests: XCTestCase {
    func testInit_empty() {
        // When
        let sut = StringOutputBuffer()

        // Then
        XCTAssertEqual(sut.flush(), "")
    }

    func testWrite_whenSingleString() {
        // Given
        let sut = StringOutputBuffer()

        // When
        sut.write("ABC")

        // Then
        XCTAssertEqual(sut.flush(), "ABC")
    }

    func testWrite_whenMultipleStrings() {
        // Given
        let sut = StringOutputBuffer()

        // When
        sut.write("A")
        sut.write("B")
        sut.write("C")

        // Then
        XCTAssertEqual(sut.flush(), "ABC")
    }
}
