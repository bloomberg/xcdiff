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

final class ComperatorTypeTests: XCTestCase {
    func testAllAvailableComparators() {
        // When / Then
        XCTAssertEqual([ComparatorType].allAvailableComparators.map { $0.tag }, [
            "file_references",
            "build_phases",
            "copy_files",
            "targets",
            "headers",
            "sources",
            "resources",
            "run_scripts",
            "configurations",
            "settings",
            "resolved_settings",
            "source_trees",
            "dependencies",
            "linked_dependencies",
            "attributes",
            "swift_packages",
        ])
    }

    func testTag_whenCustom() {
        // Given
        let comparator = ComparatorMock(tag: "Tag1")
        let subject = ComparatorType.custom(comparator)

        // When / Then
        XCTAssertEqual(subject.tag, "Tag1")
    }
}
