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

// swiftlint:disable file_length
// swiftlint:disable type_body_length
final class LinkedDependenciesComparatorTests: XCTestCase {
    private var subject: LinkedDependenciesComparator!

    override func setUp() {
        super.setUp()

        subject = LinkedDependenciesComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, "linked_dependencies")
    }

    func testCompare_whenSameDependencies_noDifferences() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_whenSameDependenciesDifferentOrder_noDifferences() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]]),
                                          LinkedDependenciesData(path: "Test100.framework"),
                                          LinkedDependenciesData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test100.framework"),
                                          LinkedDependenciesData(path: "Test.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]]),
                                          LinkedDependenciesData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_whenSingleDifferentDependency() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test1.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test2.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: []),
                                CompareResult(tag: "linked_dependencies",
                                              context: ["\"T2\" target"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [])])
    }

    func testCompare_whenTwoDifferentDependenciesSameTarget() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test100.framework"),
                                          LinkedDependenciesData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test200.framework"),
                                          LinkedDependenciesData(path: "Test200.framework"),
                                          LinkedDependenciesData(path: "Test201.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .only(target: "T1"))

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: ["Test100.framework", "Test101.framework"],
                                              onlyInSecond: ["Test200.framework", "Test201.framework"],
                                              differentValues: [])])
    }

    func testCompare_whenSingleDifferentDependencyType() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test1.framework")])
            }
            .addTarget(name: "T2") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [
                                                  CompareResult.DifferentValues(context: "Test1.framework attributes",
                                                                                first: "optional",
                                                                                second: "required"),
                                              ]),
                                CompareResult(tag: "linked_dependencies",
                                              context: ["\"T2\" target"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [])])
    }

    func testCompare_whenSingleDifferentDependencyName() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test1.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test2.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: [])])
    }

    func testCompare_whenSingleSameDependencyNameDifferentType() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test1.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [
                                                  CompareResult.DifferentValues(context: "Test1.framework attributes",
                                                                                first: "optional",
                                                                                second: "required"),
                                              ])])
    }

    func testCompare_whenAllSameDependenciesMixedNamesAndPaths() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]]),
                                          LinkedDependenciesData(path: "Test2.framework"),
                                          LinkedDependenciesData(name: "Test3.framework",
                                                                 path: "Test3.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(name: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]]),
                                          LinkedDependenciesData(path: "Test2.framework"),
                                          LinkedDependenciesData(name: "Test3.framework",
                                                                 path: "Test3.framework",
                                                                 settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1"]))
    }

    func testCompare_whenAllSameEmbeddedFrameworks() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["CodeSignOnCopy"]])])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["CodeSignOnCopy"]])])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1"]))
    }

    func testCompare_whenDifferentEmbeddedFrameworks() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": ["CodeSignOnCopy"]])])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test2.framework",
                                                                 settings: ["ATTRIBUTES": ["CodeSignOnCopy"]])])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"])])
    }

    func testCompare_whenDifferentLinkedDependenciesAndEmbeddedFrameworks() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test1.framework")])
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test2.framework",
                                                                 settings: ["ATTRIBUTES": []])])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([LinkedDependenciesData(path: "Test2.framework")])
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test3.framework",
                                                                 settings: ["ATTRIBUTES": []])])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "linked_dependencies",
                                              context: ["\"T1\" target"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: [])])
    }

    func testCompare_whenSamePackageProducts() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryA")
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryB")
                    ),
                ])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryA")
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryB")
                    ),
                ])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(
                tag: "linked_dependencies",
                context: ["\"T1\" target"],
                onlyInFirst: [],
                onlyInSecond: [],
                differentValues: []
            ),
        ])
    }

    func testCompare_whenDifferentPackageProducts() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryA")
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryB")
                    ),
                ])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryA")
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryC")
                    ),
                ])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(
                tag: "linked_dependencies",
                context: ["\"T1\" target"],
                onlyInFirst: ["LibraryB"],
                onlyInSecond: ["LibraryC"],
                differentValues: []
            ),
        ])
    }

    func testCompare_whenDifferentPackageProductsAttributes() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(
                            productName: "LibraryA",
                            package: RemoteSwiftPackageData(url: "http://testing.com/package.git")
                        )
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(
                            productName: "LibraryB",
                            package: RemoteSwiftPackageData(url: "http://testing.com/package.git")
                        )
                    ),
                ])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addLinkedDependencies([
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(
                            productName: "LibraryA",
                            package: RemoteSwiftPackageData(url: "http://testing.com/package.git")
                        )
                    ),
                    LinkedDependenciesData(
                        packageProduct: SwiftPackageProductDependencyData(productName: "LibraryB")
                    ),
                ])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(
                tag: "linked_dependencies",
                context: ["\"T1\" target"],
                onlyInFirst: [],
                onlyInSecond: [],
                differentValues: [
                    .init(
                        context: "LibraryB package reference",
                        first: "package (http://testing.com/package.git) nil",
                        second: "nil"
                    ),
                ]
            ),
        ])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        return targets.map { target in
            .init(tag: "linked_dependencies",
                  context: ["\"\(target)\" target"])
        }
    }
}
