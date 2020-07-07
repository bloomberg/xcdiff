import Foundation
@testable import XCDiffCore
import XCTest

// swiftlint:disable:next type_body_length
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
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInFirst: ["(target=T2)", "(target=T3)"]),
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
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInSecond: ["(target=T3)"]),
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
            .make(target: "T1", dependOn: .target(.init(name: nil, targetName: "T2")))
            .make(target: "T1", dependOn: .target(.init(name: nil, targetName: "T3")))
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
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInFirst: ["(target=T3)"]),
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
            .make(target: "T1", dependOn: .target(.init(name: nil, targetName: "T2")))
            .make(target: "T1", dependOn: .target(.init(name: nil, targetName: "T3")))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInSecond: ["(target=T2)", "(target=T3)"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithCustomName() throws {
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
            .make(target: "T1", dependOn: .target(.init(name: "NameT2", targetName: "T2")))
            .make(target: "T1", dependOn: .target(.init(name: "NameT3", targetName: "T3")))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"],
                  onlyInSecond: ["(name=NameT2, target=T2)", "(name=NameT3, target=T3)"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithoutTarget() throws {
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
            .make(target: "T1", dependOn: .target(.init(name: "Z1", targetName: nil)))
            .make(target: "T1", dependOn: .target(.init(name: "Z2", targetName: nil)))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"],
                  onlyInSecond: ["(name=Z1, context=none)", "(name=Z2, context=none)"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
            .init(tag: "dependencies", context: ["\"T3\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithProxy() throws {
        // Given
        let other = project(name: "PX")
            .addTarget(name: "X1")
            .projectDescriptor()
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .addTarget(name: "T2")
            .make(target: "T1", dependOn: .targetProxy(.init(name: "X1",
                                                             proxyType: nil,
                                                             containerPortal: .project(other))))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies", context: ["\"T1\" target"], onlyInSecond: ["(name=X1, proxy_project=PX)"]),
            .init(tag: "dependencies", context: ["\"T2\" target"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithProxyNativeTargetType() throws {
        // Given
        let other = project(name: "PX")
            .addTarget(name: "X1")
            .projectDescriptor()
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .make(target: "T1", dependOn: .targetProxy(.init(name: "X1",
                                                             proxyType: .nativeTarget,
                                                             containerPortal: .project(other))))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies",
                  context: ["\"T1\" target"],
                  onlyInSecond: ["(name=X1, proxy_type=native_target, proxy_project=PX)"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithProxyReferenceType() throws {
        // Given
        let other = project(name: "PX")
            .addTarget(name: "X1")
            .projectDescriptor()
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .make(target: "T1", dependOn: .targetProxy(.init(name: "X1",
                                                             proxyType: .reference,
                                                             containerPortal: .project(other))))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies",
                  context: ["\"T1\" target"],
                  onlyInSecond: ["(name=X1, proxy_type=reference, proxy_project=PX)"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithProxyOtherType() throws {
        // Given
        let other = project(name: "PX")
            .addTarget(name: "X1")
            .projectDescriptor()
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .make(target: "T1", dependOn: .targetProxy(.init(name: "X1",
                                                             proxyType: .other,
                                                             containerPortal: .project(other))))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies",
                  context: ["\"T1\" target"],
                  onlyInSecond: ["(name=X1, proxy_type=other, proxy_project=PX)"]),
        ])
    }

    func testCompare_whenDependeciesOnlyInSecondWithFileReference() throws {
        // Given
        let first = project(name: "P1")
            .addTarget(name: "T1")
            .projectDescriptor()
        let second = project(name: "P2")
            .addTarget(name: "T1")
            .make(target: "T1", dependOn: .targetProxy(.init(name: "X1",
                                                             proxyType: .reference,
                                                             containerPortal: .fileReference("filepath"))))
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "dependencies",
                  context: ["\"T1\" target"],
                  onlyInSecond: ["(name=X1, proxy_type=reference, proxy_file_reference(path=filepath))"]),
        ])
    }

    // MARK: - Helpers

    private func noDifference(targets: [String] = []) -> [CompareResult] {
        targets.map { target in
            .init(tag: "dependencies", context: ["\"\(target)\" target"])
        }
    }
}
