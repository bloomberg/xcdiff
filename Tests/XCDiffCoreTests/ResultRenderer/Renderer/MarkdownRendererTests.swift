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
    private var subject: MarkdownRenderer!
    private var outputBuffer: StringOutputBuffer!

    override func setUp() {
        super.setUp()

        outputBuffer = StringOutputBuffer()
        subject = MarkdownRenderer(output: outputBuffer.any())
    }

    func testText() {
        // When
        subject.text("1")
        subject.text("2")
        subject.text("3")

        // Then
        XCTAssertEqual(content, "1\n2\n3\n")
    }

    func testList_whenBegin() {
        // When
        subject.list(.begin)

        // Then
        XCTAssertEqual(content, "")
    }

    func testList_whenEnd() {
        // When
        subject.list(.end)

        // Then
        XCTAssertEqual(content, "\n")
    }

    func testListWithBullets() {
        // When
        subject.list(.begin)
        subject.bullet("b1", indent: .zero)
        subject.bullet("b1.1", indent: .one)
        subject.bullet("b1.2", indent: .one)
        subject.bullet("b1.2.1", indent: .two)
        subject.list(.end)

        // Then
        XCTAssertEqual(content, """
        - `b1`
          - `b1.1`
          - `b1.2`
            - `b1.2.1`\n\n
        """)
    }

    func testNewLine() {
        // When
        subject.newLine(3)

        // Then
        XCTAssertEqual(content, "\n\n\n")
    }

    func testHeader_whenH1() {
        // When
        subject.header("H1", .h1)

        // Then
        XCTAssertEqual(content, """
        \n# H1\n\n
        """)
    }

    func testHeader_whenH2() {
        // When
        subject.header("H2", .h2)

        // Then
        XCTAssertEqual(content, """
        \n## H2\n\n
        """)
    }

    func testHeader_whenH3() {
        // When
        subject.header("H3", .h3)

        // Then
        XCTAssertEqual(content, """
        \n### H3\n\n
        """)
    }

    func testSample1() {
        // When
        subject.header("Header", .h3)
        subject.list(.begin)
        subject.bullet("Different Values 1", indent: .one)
        subject.bullet("Value1", indent: .two)
        subject.bullet("Value2", indent: .two)
        subject.list(.end)
        subject.list(.begin)
        subject.bullet("Different Values 2", indent: .one)
        subject.bullet("Value1", indent: .two)
        subject.bullet("Value2", indent: .two)
        subject.list(.end)

        // Then
        XCTAssertEqual(content, """

        ### Header

          - `Different Values 1`
            - `Value1`
            - `Value2`

          - `Different Values 2`
            - `Value1`
            - `Value2`\n\n
        """)
    }

    // MARK: - Private

    private var content: String {
        return outputBuffer.flush()
    }
}
