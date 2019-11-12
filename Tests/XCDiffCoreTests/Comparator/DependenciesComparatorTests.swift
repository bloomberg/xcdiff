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
final class DependenciesComparatorTests: XCTestCase {
    private var subject: DependenciesComparator!

    override func setUp() {
        super.setUp()

        subject = DependenciesComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, Comparators.Tags.dependencies)
    }

    func testCompare_whenSameDependencies_noDifferences() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
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
                $0.addDependencies([DependencyData(path: "Test.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]]),
                                    DependencyData(path: "Test100.framework"),
                                    DependencyData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test100.framework"),
                                    DependencyData(path: "Test.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]]),
                                    DependencyData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
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
                $0.addDependencies([DependencyData(path: "Test1.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test2.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: []),
                                noDifferenceEmbeddedFrameworks(target: "T1"),
                                CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T2\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: []),
                                noDifferenceEmbeddedFrameworks(target: "T2")])
    }

    func testCompare_whenTwoDifferentDependenciesSameTarget() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test100.framework"),
                                    DependencyData(path: "Test101.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test200.framework"),
                                    DependencyData(path: "Test200.framework"),
                                    DependencyData(path: "Test201.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .only(target: "T1"))

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: ["Test100.framework", "Test101.framework"],
                                              onlyInSecond: ["Test200.framework", "Test201.framework"],
                                              differentValues: []),
                                noDifferenceEmbeddedFrameworks(target: "T1")])
    }

    func testCompare_whenSingleDifferentDependencyType() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test1.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test1.framework")])
            }
            .addTarget(name: "T2") {
                $0.addDependencies([DependencyData(path: "Test.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [
                                                  CompareResult.DifferentValues(context: "Test1.framework attributes",
                                                                                first: "optional",
                                                                                second: "required"),
                                              ]),
                                noDifferenceEmbeddedFrameworks(target: "T1"),
                                CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T2\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: []),
                                noDifferenceEmbeddedFrameworks(target: "T2")])
    }

    func testCompare_whenSingleDifferentDependencyName() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test1.framework")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test2.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: []),
                                noDifferenceEmbeddedFrameworks(target: "T1")])
    }

    func testCompare_whenSingleSameDependencyNameDifferentType() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test1.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test1.framework")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [
                                                  CompareResult.DifferentValues(context: "Test1.framework attributes",
                                                                                first: "optional",
                                                                                second: "required"),
                                              ]),
                                noDifferenceEmbeddedFrameworks(target: "T1")])
    }

    func testCompare_whenAllSameDependenciesMixedNamesAndPaths() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test1.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]]),
                                    DependencyData(path: "Test2.framework"),
                                    DependencyData(name: "Test3.framework",
                                                   path: "Test3.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]])])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(name: "Test1.framework",
                                                   settings: ["ATTRIBUTES": ["WEAK"]]),
                                    DependencyData(path: "Test2.framework"),
                                    DependencyData(name: "Test3.framework",
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
        XCTAssertEqual(actual, [noDifferenceLinkedDependencies(target: "T1"),
                                CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target"] + ["Embedded Frameworks"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: [])])
    }

    func testCompare_whenDifferentEmbeddedFrameworksCodeSignOnCopy() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test1.framework",
                                                                 settings: ["ATTRIBUTES": []])])
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
        XCTAssertEqual(actual, [noDifferenceLinkedDependencies(target: "T1"),
                                CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Embedded Frameworks"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [.init(context: "Test1.framework Code Sign on Copy",
                                                                      first: "false",
                                                                      second: "true")])])
    }

    func testCompare_whenDifferentLinkedDependenciesAndEmbeddedFrameworks() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test1.framework")])
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test2.framework",
                                                                 settings: ["ATTRIBUTES": []])])
            }
            .projectDescriptor()

        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addDependencies([DependencyData(path: "Test2.framework")])
                $0.addEmbeddedFrameworks([EmbeddedFrameworksData(path: "Test3.framework",
                                                                 settings: ["ATTRIBUTES": []])])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Linked Dependencies"],
                                              description: nil,
                                              onlyInFirst: ["Test1.framework"],
                                              onlyInSecond: ["Test2.framework"],
                                              differentValues: []),
                                CompareResult(tag: Comparators.Tags.dependencies,
                                              context: ["\"T1\" target", "Embedded Frameworks"],
                                              description: nil,
                                              onlyInFirst: ["Test2.framework"],
                                              onlyInSecond: ["Test3.framework"],
                                              differentValues: [])])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        return targets.flatMap {
            [noDifferenceLinkedDependencies(target: $0), noDifferenceEmbeddedFrameworks(target: $0)]
        }
    }

    private func noDifferenceLinkedDependencies(target: String) -> CompareResult {
        return CompareResult(tag: Comparators.Tags.dependencies,
                             context: ["\"\(target)\" target"] + ["Linked Dependencies"],
                             description: nil,
                             onlyInFirst: [],
                             onlyInSecond: [],
                             differentValues: [])
    }

    private func noDifferenceEmbeddedFrameworks(target: String) -> CompareResult {
        return CompareResult(tag: Comparators.Tags.dependencies,
                             context: ["\"\(target)\" target"] + ["Embedded Frameworks"],
                             description: nil,
                             onlyInFirst: [],
                             onlyInSecond: [],
                             differentValues: [])
    }
}
