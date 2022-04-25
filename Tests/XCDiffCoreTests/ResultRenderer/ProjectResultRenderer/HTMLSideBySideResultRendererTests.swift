//
// Copyright 2022 Bloomberg Finance L.P.
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

final class HTMLSideBySideResultRendererTests: XCTestCase {
    private var outputBuffer: StringOutputBuffer!
    private let fixtures = Fixtures()

    override func setUpWithError() throws {
        outputBuffer = StringOutputBuffer()
    }

    override func tearDownWithError() throws {}

    // MARK: - Tests

    func testRender_notVerbose_doesNotContainDetails() throws {
        // Given
        let subject = makeSubject(verbose: false)
        let result = fixtures.projectCompareResult.create([
            CompareResult(tag: "Tag1", onlyInFirst: ["Tag1.value.a"], onlyInSecond: ["Tag1.value.b"]),
            CompareResult(tag: "Tag2", onlyInFirst: ["Tag2.value.a"], onlyInSecond: ["Tag2.value.b"]),
        ])

        // When
        try subject.render(result)

        // Then
        let content = outputBuffer.flush()

        // note we are doing partial matches as we don't want to do exact matches on
        // the entire html content
        XCTAssertTrue(content.contains("TAG1"))
        XCTAssertTrue(content.contains("TAG2"))
        XCTAssertFalse(content.contains("Tag1.value.a"))
        XCTAssertFalse(content.contains("Tag1.value.b"))
        XCTAssertFalse(content.contains("Tag2.value.a"))
        XCTAssertFalse(content.contains("Tag2.value.b"))
    }

    func testRender_verbose_containsDetails() throws {
        // Given
        let subject = makeSubject(verbose: true)
        let result = fixtures.projectCompareResult.create([
            CompareResult(tag: "Tag1", onlyInFirst: ["Tag1.value.a"], onlyInSecond: ["Tag1.value.b"]),
            CompareResult(tag: "Tag2", onlyInFirst: ["Tag2.value.a"], onlyInSecond: ["Tag2.value.b"]),
        ])

        // When
        try subject.render(result)

        // Then
        let content = outputBuffer.flush()

        // note we are doing partial matches as we don't want to do exact matches on
        // the entire html content
        XCTAssertTrue(content.contains("TAG1"))
        XCTAssertTrue(content.contains("TAG2"))
        XCTAssertTrue(content.contains("Tag1.value.a"))
        XCTAssertTrue(content.contains("Tag1.value.b"))
        XCTAssertTrue(content.contains("Tag2.value.a"))
        XCTAssertTrue(content.contains("Tag2.value.b"))
    }

    func testRender_contentIsEscaped() throws {
        // Given
        let subject = makeSubject(verbose: true)
        let result = fixtures.projectCompareResult.create([
            CompareResult(
                tag: "Tag1 & A",
                description: "a > b < c",
                onlyInFirst: ["a'b", "c<>d"],
                onlyInSecond: ["e\"f"],
                differentValues: [
                    .init(context: "XY&Z", first: "x1<>y1", second: "z2'\"z3"),
                ]
            ),
        ])

        // When
        try subject.render(result)

        // Then
        let content = outputBuffer.flush()

        XCTAssertTrue(content.contains("TAG1 &amp; A"))
        XCTAssertTrue(content.contains("a &#x3E; b &#x3C; c"))
        XCTAssertTrue(content.contains("a&#39;b"))
        XCTAssertTrue(content.contains("c&#x3C;&#x3E;d"))
        XCTAssertTrue(content.contains("e&quot;f"))
        XCTAssertTrue(content.contains("XY&amp;Z"))
        XCTAssertTrue(content.contains("x1&#x3C;&#x3E;y1"))
        XCTAssertTrue(content.contains("z2&#39;&quot;z3"))
    }

    // MARK: - Helpers

    private func makeSubject(verbose: Bool) -> HTMLSideBySideResultRenderer {
        HTMLSideBySideResultRenderer(
            output: outputBuffer.any(),
            verbose: verbose
        )
    }
}
