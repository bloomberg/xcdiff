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

final class MarkdownRendererTests: XCTestCase {
    private var sut: MarkdownRenderer!
    private var outputBuffer: StringOutputBuffer!

    override func setUp() {
        super.setUp()

        outputBuffer = StringOutputBuffer()
        sut = MarkdownRenderer(output: outputBuffer.any())
    }

    func testText() {
        // When
        sut.text("1")
        sut.text("2")
        sut.text("3")

        // Then
        XCTAssertEqual("1\n2\n3\n", outputBuffer.flush())
    }

    func testList_whenBegin() {
        // When
        sut.list(.begin)

        // Then
        XCTAssertEqual("", outputBuffer.flush())
    }

    func testList_whenEnd() {
        // When
        sut.list(.end)

        // Then
        XCTAssertEqual("\n", outputBuffer.flush())
    }

    func testListWithBullets() {
        // When
        sut.list(.begin)
        sut.bullet("b1", indent: .zero)
        sut.bullet("b1.1", indent: .one)
        sut.bullet("b1.2", indent: .one)
        sut.bullet("b1.2.1", indent: .two)
        sut.list(.end)

        // Then
        XCTAssertEqual("""
        - `b1`
          - `b1.1`
          - `b1.2`
            - `b1.2.1`\n\n
        """, content())
    }

    func testNewLine() {
        // When
        sut.newLine(3)

        // Then
        XCTAssertEqual("\n\n\n", content())
    }

    func testHeader_whenH1() {
        // When
        sut.header("H1", .h1)

        // Then
        XCTAssertEqual("""
        \n# H1\n\n
        """, content())
    }

    func testHeader_whenH2() {
        // When
        sut.header("H2", .h2)

        // Then
        XCTAssertEqual("""
        \n## H2\n\n
        """, content())
    }

    func testHeader_whenH3() {
        // When
        sut.header("H3", .h3)

        // Then
        XCTAssertEqual("""
        \n### H3\n\n
        """, content())
    }

    func testSample1() {
        // When
        sut.header("Header", .h3)
        sut.list(.begin)
        sut.bullet("Different Values 1", indent: .one)
        sut.bullet("Value1", indent: .two)
        sut.bullet("Value2", indent: .two)
        sut.list(.end)
        sut.list(.begin)
        sut.bullet("Different Values 2", indent: .one)
        sut.bullet("Value1", indent: .two)
        sut.bullet("Value2", indent: .two)
        sut.list(.end)

        // Then
        XCTAssertEqual("""

        ### Header

          - `Different Values 1`
            - `Value1`
            - `Value2`

          - `Different Values 2`
            - `Value1`
            - `Value2`\n\n
        """, content())
    }

    // MARK: - Private

    func content() -> String {
        return outputBuffer.flush()
    }
}
