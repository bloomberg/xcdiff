//
// Copyright 2025 Bloomberg Finance L.P.
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

// swiftlint:disable:next type_name
final class FileSytemSynchronizedGroupsComparatorTests: XCTestCase {
    private var subject: FileSytemSynchronizedGroupsComparator!

    override func setUp() {
        super.setUp()

        subject = FileSytemSynchronizedGroupsComparator()
    }

    // MARK: - Tests

    func testCompare_whenNoSyncGroups() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .projectDescriptor()

        // When
        let actual = try subject.compare(
            first,
            second,
            parameters: .all
        )

        // Then
        XCTAssertEqual(actual, [
            .init(
                tag: "filesystem_synchronized_groups",
                context: ["\"T1\" target"]
            ),
        ])
    }

    func testCompare_whenMatchingSyncGroups() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") { targert in
                targert.addFileSystemSynchronizedRootGroups(["A", "B"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") { targert in
                targert.addFileSystemSynchronizedRootGroups(["A", "B"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(
                tag: "filesystem_synchronized_groups",
                context: ["\"T1\" target"]
            ),
        ])
    }

    func testCompare_whenNonMatchingSyncGroups() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") { targert in
                targert.addFileSystemSynchronizedRootGroups(["A", "B"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") { targert in
                targert.addFileSystemSynchronizedRootGroups(["A", "B", "C"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(
            first,
            second,
            parameters: .all
        )

        // Then
        XCTAssertEqual(actual, [
            .init(
                tag: "filesystem_synchronized_groups",
                context: ["\"T1\" target"],
                onlyInSecond: ["C"]
            ),
        ])
    }
}
