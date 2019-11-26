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

final class URLExtensionsTests: XCTestCase {
    func testRelative_whenRelativePathIsParent() {
        XCTAssertEqual(computeRelative("/usr/bin/agent/demo.gz", "/usr/bin"), "agent/demo.gz")
        XCTAssertEqual(computeRelative("/user/db/demo.exe", "/user/tb"), "../db/demo.exe")
    }

    func testRelative_whenPathIsEmpty() {
        XCTAssertEqual(computeRelative("/", "/"), "")
    }

    func testRelative_whenRelativePathIsChild() {
        XCTAssertEqual(computeRelative("/user/x/y", "/user/x/y/a/b/c"), "../../..")
    }

    func testRelative_whenRelativeHasNoBase_nilIsReturned() {
        XCTAssertNil(computeRelative(fileURLWithPath: "x/y/z", urlString: "file:///"))
    }

    func testRelative_whenRelativeIsNotFilePath_nilIsReturned() {
        XCTAssertNil(computeRelative(fileURLWithPath: "x/y/z", urlString: "https://demo.com"))
    }

    // MARK: - Private

    private func computeRelative(_ first: String, _ second: String) -> String? {
        let firstLink = URL(fileURLWithPath: first)
        let secondLink = URL(fileURLWithPath: second)
        return firstLink.relative(to: secondLink)
    }

    private func computeRelative(fileURLWithPath first: String,
                                 urlString second: String) -> String? {
        let firstLink = URL(fileURLWithPath: first)
        guard let secondLink = URL(string: second) else {
            XCTFail("Failed to init URL from \(second)")
            return nil
        }
        return firstLink.relative(to: secondLink)
    }
}
