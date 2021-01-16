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

final class SwiftPackagesComparatorTests: XCTestCase {
    private var subject: SwiftPackagesComparator!

    override func setUp() {
        subject = SwiftPackagesComparator()
    }

    func testCompare_whenNoAttributes() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "swift_packages",
                context: []
            ),
        ])
    }

    func testCompare_whenSamePackages() throws {
        // Given
        let first = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()
        let second = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "swift_packages"
            ),
        ])
    }

    func testCompare_whenPackageOnlyInFirst() throws {
        // Given
        let first = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()
        let second = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "swift_packages",
                onlyInFirst: ["package-b (https://testing.com/package-b.git) .upToNextMajorVersion(0.1.0)"]
            ),
        ])
    }

    func testCompare_whenPackageOnlyInSecond() throws {
        // Given
        let first = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()
        let second = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "swift_packages",
                onlyInSecond: ["package-b (https://testing.com/package-b.git) .upToNextMajorVersion(0.1.0)"]
            ),
        ])
    }

    func testCompare_whenDifferentPackageVersions() throws {
        // Given
        let first = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-c.git", version: .upToNextMajorVersion("0.1.0"))
            .projectDescriptor()
        let second = project()
            .addRemoteSwiftPackage(url: "https://testing.com/package-a.git", version: .upToNextMajorVersion("0.1.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-b.git", version: .upToNextMajorVersion("0.2.0"))
            .addRemoteSwiftPackage(url: "https://testing.com/package-c.git", version: .exact("0.1.0"))
            .projectDescriptor()

        // When
        let result = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(result, [
            .init(
                tag: "swift_packages",
                differentValues: [
                    .init(
                        context: "package-b (https://testing.com/package-b.git)",
                        first: "version = .upToNextMajorVersion(0.1.0)",
                        second: "version = .upToNextMajorVersion(0.2.0)"
                    ),
                    .init(
                        context: "package-c (https://testing.com/package-c.git)",
                        first: "version = .upToNextMajorVersion(0.1.0)",
                        second: "version = .exact(0.1.0)"
                    ),
                ]
            ),
        ])
    }
}
