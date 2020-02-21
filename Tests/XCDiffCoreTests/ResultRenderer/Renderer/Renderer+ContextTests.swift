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

final class RendererContextTests: XCTestCase {
    private var consoleStringOutputBuffer: StringOutputBuffer!
    private var consoleRenderer: ConsoleRenderer!

    private var markdownOutputBuffer: StringOutputBuffer!
    private var markdownRenderer: MarkdownRenderer!

    private var subject: ForwardRenderer!

    override func setUp() {
        super.setUp()

        consoleStringOutputBuffer = StringOutputBuffer()
        consoleRenderer = ConsoleRenderer(output: consoleStringOutputBuffer.any())

        markdownOutputBuffer = StringOutputBuffer()
        markdownRenderer = MarkdownRenderer(output: markdownOutputBuffer.any())

        subject = ForwardRenderer(consoleRenderer, markdownRenderer)
    }

    func testOnlyInFirstHeader_whenNoCount() {
        // When
        subject.onlyInFirstHeader()

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Only in first:\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Only in first:\n\n
        """)
    }

    func testOnlyInFirstHeader_whenCount5() {
        // When
        subject.onlyInFirstHeader(count: 5)

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Only in first (5):\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Only in first (5):\n\n
        """)
    }

    func testOnlyInSecondHeader_whenNoCount() {
        // When
        subject.onlyInSecondHeader()

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Only in second:\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Only in second:\n\n
        """)
    }

    func testOnlyInSecondHeader_whenCount5() {
        // When
        subject.onlyInSecondHeader(count: 5)

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Only in second (5):\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Only in second (5):\n\n
        """)
    }

    func testDifferentValuesHeader_whenNoCount() {
        // When
        subject.differentValuesHeader()

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Value mismatch:\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Value mismatch:\n\n
        """)
    }

    func testDifferentValuesHeader_whenCount5() {
        // When
        subject.differentValuesHeader(count: 5)

        // Then
        XCTAssertEqual(consoleContent, """
        \n⚠️  Value mismatch (5):\n\n
        """)

        XCTAssertEqual(markdownContent, """
        \n### ⚠️  Value mismatch (5):\n\n
        """)
    }

    func testSuccessHeader() {
        // When
        subject.successHeader("Header")

        // Then
        XCTAssertEqual(consoleContent, """
        ✅ Header\n
        """)

        XCTAssertEqual(markdownContent, """
        \n## ✅ Header\n\n
        """)
    }

    func testErrorHeader() {
        // When
        subject.errorHeader("Header")

        // Then
        XCTAssertEqual(consoleContent, """
        ❌ Header\n
        """)

        XCTAssertEqual(markdownContent, """
        \n## ❌ Header\n\n
        """)
    }

    func testConsoleRenderer_whenSample1() {
        // When
        setupSample1()

        // Then
        XCTAssertEqual(consoleContent, """
        ✅ Success1
        ✅ Success2
        ❌ Error1

        ⚠️  Only in first (2):

          • B1
          • B2\n

        ⚠️  Only in second (2):

          • C1
          • C2\n

        ⚠️  Value mismatch (2):

          • Context1
            ◦ V1.1
            ◦ V1.1

          • Context2
            ◦ V2.1
            ◦ V2.1\n

        ✅ Success3\n
        """)
    }

    func testMarkdownRenderer_whenSample1() {
        // When
        setupSample1()

        // Then
        XCTAssertEqual(markdownContent, """

        ## ✅ Success1\n

        ## ✅ Success2\n

        ## ❌ Error1\n

        ### ⚠️  Only in first (2):

          - `B1`
          - `B2`\n

        ### ⚠️  Only in second (2):

          - `C1`
          - `C2`\n

        ### ⚠️  Value mismatch (2):

          - `Context1`
            - `V1.1`
            - `V1.1`

          - `Context2`
            - `V2.1`
            - `V2.1`\n\n

        ## ✅ Success3\n\n
        """)
    }

    // MARK: - Private

    private func setupSample1() {
        subject.successHeader("Success1")
        subject.successHeader("Success2")
        subject.errorHeader("Error1")
        subject.onlyInFirstHeader(count: 2)
        subject.list(.begin)
        subject.bullet("B1", indent: .one)
        subject.bullet("B2", indent: .one)
        subject.list(.end)
        subject.onlyInSecondHeader(count: 2)
        subject.list(.begin)
        subject.bullet("C1", indent: .one)
        subject.bullet("C2", indent: .one)
        subject.list(.end)
        subject.differentValuesHeader(count: 2)
        subject.list(.begin)
        subject.bullet("Context1", indent: .one)
        subject.bullet("V1.1", indent: .two)
        subject.bullet("V1.1", indent: .two)
        subject.list(.end)
        subject.list(.begin)
        subject.bullet("Context2", indent: .one)
        subject.bullet("V2.1", indent: .two)
        subject.bullet("V2.1", indent: .two)
        subject.list(.end)
        subject.newLine(1)
        subject.successHeader("Success3")
    }

    private var consoleContent: String {
        return consoleStringOutputBuffer.flush()
    }

    private var markdownContent: String {
        return markdownOutputBuffer.flush()
    }
}

final class ForwardRenderer: Renderer {
    private let renderers: [Renderer]

    init(_ renderers: Renderer...) {
        self.renderers = renderers
    }

    // MARK: - Renderer

    func text(_ text: String) {
        forEach { $0.text(text) }
    }

    func list(_ element: RendererElement.List) {
        forEach { $0.list(element) }
    }

    func bullet(_ text: String, indent: RendererElement.Indent) {
        forEach { $0.bullet(text, indent: indent) }
    }

    func newLine(_ count: Int) {
        forEach { $0.newLine(count) }
    }

    func header(_ text: String, _ header: RendererElement.Header) {
        forEach { $0.header(text, header) }
    }

    // MARK: - Private

    private func forEach(_ closure: (Renderer) -> Void) {
        renderers.forEach(closure)
    }
}
