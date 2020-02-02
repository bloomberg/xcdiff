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

final class DefaultXcodeProjLoaderTests: XCTestCase {
    private var subject: DefaultXcodeProjLoader!
    private let fixtures = Fixtures()

    override func setUp() {
        super.setUp()

        subject = DefaultXcodeProjLoader()
    }

    func testLoad_whenProjectExists() throws {
        // Given
        let path = fixtures.project.ios_project_1()

        // When
        let xcodeProj = try subject.load(at: path)

        // Then
        XCTAssertNotNil(xcodeProj)
        XCTAssertNotNil(xcodeProj.pbxproj)
    }

    func testLoad_whenProjectNotExists() {
        // Given
        let path = fixtures.project.non_existing()

        // When / Then
        XCTAssertThrowsError(try subject.load(at: path)) { error in
            guard let error = error as? ComparatorError else {
                XCTFail("Expected ComparatorError")
                return
            }
            XCTAssertEqual(error.localizedDescription, "The project cannot be found at \(path.string)")
        }
    }
}
