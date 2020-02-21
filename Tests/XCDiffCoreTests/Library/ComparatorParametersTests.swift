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

final class ComparatorParametersTests: XCTestCase {
    func testInit() {
        // When
        let subject = ComparatorParameters(targets: .all, configurations: .none)

        // Then
        XCTAssertEqual(subject.targets, .all)
        XCTAssertEqual(subject.configurations, .none)
    }

    func testOptionFilter_whenNone() {
        // Given
        let subject: ComparatorParameters.Option<String> = .none
        let data = ["A", "B", "C"]

        // When / Then
        XCTAssertEqual(data.filter(by: subject), [])
    }

    func testOptionFilter_whenOnly() {
        // Given
        let subject: ComparatorParameters.Option<String> = .only("B")
        let data = ["A", "B", "C"]

        // When / Then
        XCTAssertEqual(data.filter(by: subject), ["B"])
    }

    func testOptionFilter_whenSome() {
        // Given
        let subject: ComparatorParameters.Option<String> = .some(["B", "C"])
        let data = ["A", "B", "C"]

        // When / Then
        XCTAssertEqual(data.filter(by: subject), ["B", "C"])
    }

    func testOptionFilter_whenAll() {
        // Given
        let subject: ComparatorParameters.Option<String> = .all
        let data = ["A", "B", "C"]

        // When / Then
        XCTAssertEqual(data.filter(by: subject), ["A", "B", "C"])
    }

    func testValues() {
        // Given
        let subject1: ComparatorParameters.Option<String> = .all
        let subject2: ComparatorParameters.Option<String> = .only("A")
        let subject3: ComparatorParameters.Option<String> = .some(["A", "B"])
        let subject4: ComparatorParameters.Option<String> = .none

        // When / Then
        XCTAssertNil(subject1.values())
        XCTAssertEqual(subject2.values(), ["A"])
        XCTAssertEqual(subject3.values(), ["A", "B"])
        XCTAssertEqual(subject4.values(), [])
    }

    func testContains() {
        // Given
        let subject1: ComparatorParameters.Option<String> = .all
        let subject2: ComparatorParameters.Option<String> = .only("A")
        let subject3: ComparatorParameters.Option<String> = .some(["A", "B"])
        let subject4: ComparatorParameters.Option<String> = .none

        // When / Then
        XCTAssertTrue(subject1.contains("A"))
        XCTAssertTrue(subject2.contains("A"))
        XCTAssertTrue(subject3.contains("A"))
        XCTAssertFalse(subject4.contains("A"))
    }
}
