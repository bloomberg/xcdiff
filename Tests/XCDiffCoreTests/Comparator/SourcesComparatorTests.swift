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

@testable import XCDiffCore
import XCTest

final class SourcesComparatorTests: XCTestCase {
    private var subject: SourcesComparator!

    override func setUp() {
        subject = SourcesComparator()
    }

    // MARK: - Tests

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, Comparators.Tags.sources)
    }

    func testCompare_sameSources_allTargets() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_sameSources_someTargets() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T3") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T3") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .some(targets: ["T1", "T2"]))

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_sameSources_onlyTarget() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .addTarget(name: "T2") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp", "E.c"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .only(target: "T2"))

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T2"]))
    }

    func testCompare_differentSources() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "D.cpp"])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addSources(["A.swift", "B.m", "C.mm", "E.c"])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: Comparators.Tags.sources,
                          context: ["\"T1\" target"],
                          description: nil,
                          onlyInFirst: ["D.cpp"],
                          onlyInSecond: ["E.c"],
                          differentValues: []),
        ])
    }

    func testCompare_differentSourceSettings() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1") {
                $0.addSources([(name: "B.m", flags: "-foo")])
            }
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1") {
                $0.addSources([(name: "B.m", flags: "-bar")])
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first,
                                         second,
                                         parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            CompareResult(tag: Comparators.Tags.sources,
                          context: ["\"T1\" target"],
                          description: nil,
                          onlyInFirst: [],
                          onlyInSecond: [],
                          differentValues: [
                              .init(context: "B.m compiler flags",
                                    first: "-foo",
                                    second: "-bar"),
                          ]),
        ])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        return targets.map {
            CompareResult(tag: Comparators.Tags.sources,
                          context: ["\"\($0)\" target"],
                          description: nil,
                          onlyInFirst: [],
                          onlyInSecond: [],
                          differentValues: [])
        }
    }
}
