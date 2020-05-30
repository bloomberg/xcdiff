//
// Copyright 2020 Bloomberg Finance L.P.
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

final class HTMLRendererTests: XCTestCase {
    private var subject: HTMLRenderer!
    private var outputBuffer: StringOutputBuffer!

    override func setUp() {
        super.setUp()

        outputBuffer = StringOutputBuffer()
        subject = HTMLRenderer(output: outputBuffer.any())
    }

    func testText() {
        // When
        subject.text("1")
        subject.text("2")
        subject.text("3")

        // Then
        XCTAssertEqual(content, "<p>1</p><p>2</p><p>3</p>")
    }

    func testList_whenEmpty() {
        // When
        subject.list {}

        // Then
        XCTAssertEqual(content, "<ul></ul>")
    }

    func testList_whenItems() {
        // When
        subject.list {
            subject.item("b1.1")
            subject.item {
                subject.pre("b1.2")
                subject.list {
                    subject.item("b1.2.1")
                }
            }
            subject.item {
                subject.pre("b2.2")
                subject.list {
                    subject.item("b2.2.1")
                }
            }
        }

        // Then
        XCTAssertEqual(content, "<ul><li>b1.1</li><li><p>b1.2</p><ul><li>b1.2.1</li></ul></li>"
            + "<li><p>b2.2</p><ul><li>b2.2.1</li></ul></li></ul>")
    }

    func testLine() {
        // When
        subject.line(3)

        // Then
        XCTAssertEqual(content, "")
    }

    func testHeader_whenH1() {
        // When
        subject.header("H1", .h1)

        // Then
        XCTAssertEqual(content, "<h1>H1</h1>")
    }

    func testHeader_whenH2() {
        // When
        subject.header("H2", .h2)

        // Then
        XCTAssertEqual(content, "<h2>H2</h2>")
    }

    func testHeader_whenH3() {
        // When
        subject.header("H3", .h3)

        // Then
        XCTAssertEqual(content, "<h3>H3</h3>")
    }

    func testSample1() {
        // When
        subject.header("Header", .h3)
        subject.list {
            subject.item {
                subject.pre("Different Values 1")
                subject.list {
                    subject.item("Value1")
                    subject.item("Value2")
                }
            }
            subject.item {
                subject.pre("Different Values 2")
                subject.list {
                    subject.item("Value1")
                    subject.item("Value2")
                }
            }
        }
        subject.header("Header 2", .h3)
        subject.list {
            subject.item("Test")
        }

        // Then
        XCTAssertEqual(content, "<h3>Header</h3><ul><li><p>Different Values 1</p>"
            + "<ul><li>Value1</li><li>Value2</li></ul></li><li><p>Different Values 2</p>"
            + "<ul><li>Value1</li><li>Value2</li></ul></li></ul><h3>Header 2</h3><ul><li>Test</li></ul>")
    }

    // MARK: - Private

    private var content: String {
        return outputBuffer.flush()
    }
}
