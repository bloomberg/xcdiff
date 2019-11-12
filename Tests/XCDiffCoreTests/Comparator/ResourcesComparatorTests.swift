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

final class ResourcesComparatorTests: XCTestCase {
    private var subject: ResourcesComparator!

    override func setUp() {
        super.setUp()

        subject = ResourcesComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, Comparators.Tags.resources)
    }

    func testCompare_sameResources_allTargets() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_sameResources_someTargets() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T3") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T3") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .some(targets: ["T1", "T2"]))

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_sameResources_onlyTarget() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .addTarget(name: "T2") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .only(target: "T2"))

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T2"]))
    }

    func testCompare_differentResources() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "B.png", "C.pdf", "D.xib", "E.storyboard"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addResources(["A.png", "D.xib", "E.storyboard", "F.xcassets", "G.pdf"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: Comparators.Tags.resources,
                          context: ["\"T1\" target"],
                          description: nil,
                          onlyInFirst: ["B.png", "C.pdf"],
                          onlyInSecond: ["F.xcassets", "G.pdf"],
                          differentValues: []),
        ])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        return targets.map {
            CompareResult(tag: Comparators.Tags.resources,
                          context: ["\"\($0)\" target"],
                          description: nil,
                          onlyInFirst: [],
                          onlyInSecond: [],
                          differentValues: [])
        }
    }
}
