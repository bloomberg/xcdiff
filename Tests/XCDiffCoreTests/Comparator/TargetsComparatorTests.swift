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

final class TargetsComparatorTests: XCTestCase {
    private var sut: TargetsComparator!

    override func setUp() {
        super.setUp()

        sut = TargetsComparator()
    }

    func testTag() {
        // When / Then
        XCTAssertEqual(sut.tag, ComparatorTag.targets)
    }

    func testCompare_whenHaveNoTargets() throws {
        // Given
        let first = project()
            .projectDescriptor()
        let second = project()
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: ComparatorTag.targets, context: ["NATIVE targets"]),
            CompareResult(tag: ComparatorTag.targets, context: ["AGGREGATE targets"]),
        ])
    }

    func testCompare_whenHaveSameTargets() throws {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "C"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A", "B", "C"])
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: ComparatorTag.targets, context: ["NATIVE targets"]),
            CompareResult(tag: ComparatorTag.targets, context: ["AGGREGATE targets"]),
        ])
    }

    func testCompare_whenHaveDifferentTargets() throws {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "C_UPDATED", "D_NEW"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A_UPDATED", "B", "C", "E_NEW"])
            .addAggregateTarget(name: "NEW_AGGREGATE")
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second, parameters: .all)

        // Then
        let expected = [
            CompareResult(tag: ComparatorTag.targets,
                          context: ["NATIVE targets"],
                          onlyInFirst: ["A", "C_UPDATED", "D_NEW"],
                          onlyInSecond: ["A_UPDATED", "C", "E_NEW"]),
            CompareResult(tag: ComparatorTag.targets,
                          context: ["AGGREGATE targets"],
                          onlyInSecond: ["NEW_AGGREGATE"]),
        ]
        XCTAssertEqual(actual, expected)
    }

    func testCompare_whenHaveDifferentTargetsAndTargetSomeFilter() throws {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "X1", "X2"])
            .addAggregateTargets(names: ["C", "E"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["X1", "B", "X3"])
            .addAggregateTargets(names: ["C", "D"])
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second,
                                     parameters: .init(targets: .some(["A", "B", "C", "D"]), configurations: .none))

        // Then
        let expected = [
            CompareResult(tag: ComparatorTag.targets,
                          context: ["NATIVE targets"],
                          onlyInFirst: ["A"],
                          onlyInSecond: []),
            CompareResult(tag: ComparatorTag.targets,
                          context: ["AGGREGATE targets"],
                          onlyInFirst: [],
                          onlyInSecond: ["D"]),
        ]
        XCTAssertEqual(actual, expected)
    }

    func testCompare_whenFilterNonExistingTargetName() {
        // Given
        let first = project()
            .addTargets(names: ["A", "B", "C"])
            .addAggregateTargets(names: ["D", "E"])
            .projectDescriptor()
        let second = project()
            .addTargets(names: ["A", "B", "C"])
            .addAggregateTargets(names: ["D", "E"])
            .projectDescriptor()
        let parameters = ComparatorParameters(targets: .only("NOT_EXISTING"),
                                              configurations: .all)

        // When / Then
        XCTAssertThrowsError(try sut.compare(first, second, parameters: parameters)) { error in
            XCTAssertEqual(error.localizedDescription, "Cannot find target \"NOT_EXISTING\" in both projects")
        }
    }

    func testCompare_whenCommonTargetHaveDifferentProductTypes() throws {
        // Given
        let first = project()
            .addTarget(name: "A", productType: .application)
            .addTarget(name: "B", productType: .framework)
            .addTarget(name: "C", productType: .unitTestBundle)
            .projectDescriptor()
        let second = project()
            .addTarget(name: "A", productType: .application)
            .addTarget(name: "B", productType: .staticLibrary)
            .addTarget(name: "C", productType: .uiTestBundle)
            .projectDescriptor()

        // When
        let actual = try sut.compare(first, second,
                                     parameters: .all)

        // Then
        let expected = [
            CompareResult(tag: ComparatorTag.targets,
                          context: ["NATIVE targets"],
                          onlyInFirst: [],
                          onlyInSecond: [],
                          differentValues: [
                              .init(context: "B product type",
                                    first: "com.apple.product-type.framework",
                                    second: "com.apple.product-type.library.static"),
                              .init(context: "C product type",
                                    first: "com.apple.product-type.bundle.unit-test",
                                    second: "com.apple.product-type.bundle.ui-testing"),
                          ]),
            CompareResult(tag: ComparatorTag.targets,
                          context: ["AGGREGATE targets"],
                          onlyInFirst: [],
                          onlyInSecond: []),
        ]
        XCTAssertEqual(actual, expected)
    }
}
