import Foundation
@testable import XCDiffCore
import XCTest

final class DependenciesTests: XCTestCase {
    private var subject: DependenciesComparator!

    override func setUp() {
        super.setUp()

        subject = DependenciesComparator()
    }

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, "dependencies")
    }

    func testCompare_whenNoDependencies() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, noDifference(targets: ["T1", "T2"]))
    }

    func testCompare_whenDependenciesOnlyInFirst() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: ["T2", "T3"])
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInFirst: ["T2", "T3"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependenciesOnlyInSecond() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: ["T2"])
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: ["T2", "T3"])
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInSecond: ["T3"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInFirstWithoutName() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: DependencyData(name: nil, targetName: "T2"))
            .make(target: "T1", dependOn: DependencyData(name: nil, targetName: "T3"))
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: ["T2"])
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInFirst: ["T3"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithoutName() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .addTarget(name: "T3")
            .make(target: "T1", dependOn: DependencyData(name: nil, targetName: "T2"))
            .make(target: "T1", dependOn: DependencyData(name: nil, targetName: "T3"))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInSecond: ["T2", "T3"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        targets.map { target in
            .init(tag: "dependencies", context: ["\"\(target)\" target"])
        }
    }
}
