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

// swiftlint:disable file_length
// swiftlint:disable:next type_body_length
final class CopyFilesComparatorTests: XCTestCase {
    private var subject: CopyFilesComparator!

    override func setUp() {
        super.setUp()

        subject = CopyFilesComparator()
    }

    func testTag() {
        // When / Then
        XCTAssertEqual(subject.tag, "copy_files")
    }

    func testCompare_whenNoCopyFilesBuildPhase() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { _ in }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { _ in }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "copy_files", context: ["\"Target1\" target"])])
    }

    func testCompare_whenCopyFilesBuildPhaseOnlyInFirst_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { _ in }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "copy_files", context: ["\"Target1\" target"])])
    }

    func testCompare_whenMoreThanOneCopyFilesBuildPhaseWithTheSameNameInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"]),
            .init(tag: "copy_files", context: ["\"Target1\" target", "CopyFiles"],
                  description: "The build phase does not exist in the second project",
                  onlyInFirst: ["Duplicated build phase name"]),
        ])
    }

    func testCompare_whenMoreThanOneCopyFilesBuildPhaseWithTheSameNameInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"]),
            .init(tag: "copy_files", context: ["\"Target1\" target", "CopyFiles"],
                  description: "The build phase does not exist in the first project",
                  onlyInSecond: ["Duplicated build phase name"]),
        ])
    }

    func testCompare_whenCopyFilesBuildPhaseOnlyInSecond_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { _ in }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "copy_files", context: ["\"Target1\" target"])])
    }

    func testCompare_whenSameCopyFilesBuildPhaseInBoth_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "copy_files", context: ["\"Target1\" target", "CopyFiles"])])
    }

    func testCompare_whenFileOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a.txt") }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  onlyInFirst: ["a.txt"]),
        ])
    }

    func testCompare_whenFileOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a.txt") }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  onlyInSecond: ["a.txt"]),
        ])
    }

    func testCompare_whenDstPathOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copeFilesBuildPhase = CopyFilesBuildPhase(name: nil,
                                                              dstSubfolderSpec: .frameworks,
                                                              dstPath: "subfolder/a")
                target.addBuildPhase(.copyFiles(copeFilesBuildPhase)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  differentValues: [
                      .init(context: "dstPath",
                            first: "subfolder/a",
                            second: "nil"),
                  ]),
        ])
    }

    func testCompare_whenDstPathOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copeFilesBuildPhase = CopyFilesBuildPhase(name: nil,
                                                              dstSubfolderSpec: .frameworks,
                                                              dstPath: "subfolder/a")
                target.addBuildPhase(.copyFiles(copeFilesBuildPhase)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  differentValues: [
                      .init(context: "dstPath",
                            first: "nil",
                            second: "subfolder/a"),
                  ]),
        ])
    }

    func testCompare_whenSameBuildPhaseDifferentProperties() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase
                        .setInputFileListPaths(["input1.txt"])
                        .setOutputFileListPaths(["output1.txt"])
                        .setRunOnlyForDeploymentPostprocessing(false)
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase
                        .setInputFileListPaths(["input2.txt"])
                        .setOutputFileListPaths(["output2.txt"])
                        .setRunOnlyForDeploymentPostprocessing(true)
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  differentValues: [
                      .init(context: "runOnlyForDeploymentPostprocessing", first: "false", second: "true"),
                      .init(context: "inputFileListPaths", first: "[\"input1.txt\"]", second: "[\"input2.txt\"]"),
                      .init(context: "outputFileListPaths", first: "[\"output1.txt\"]", second: "[\"output2.txt\"]"),
                  ]),
        ])
    }

    func testCompare_whenEmptyEqualsNilInputAndOutpulFileListPaths() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase
                        .setInputFileListPaths([])
                        .setOutputFileListPaths([])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files", context: ["\"Target1\" target", "CopyFiles"]),
        ])
    }

    func testCompare_whenSameBuildPhaseNameButDifferentDstfolderSpec() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copyFilesBuildPhase = CopyFilesBuildPhase(name: "BuildPhaseName",
                                                              dstSubfolderSpec: .frameworks)
                target.addBuildPhase(.copyFiles(copyFilesBuildPhase)) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copyFilesBuildPhase = CopyFilesBuildPhase(name: "BuildPhaseName",
                                                              dstSubfolderSpec: .plugins)
                target.addBuildPhase(.copyFiles(copyFilesBuildPhase)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "BuildPhaseName"],
                  differentValues: [
                      .init(context: "dstSubfolderSpec", first: "frameworks", second: "plugins"),
                  ]),
        ])
    }

    func testCompare_whenSameBuildPhaseDifferentFileProperties() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { file in
                        file.setPath("a.txt")
                            .setSettings(["ATTRIBUTES": ["A1", "B1"]])
                            .setPlatformFilter("ios")
                    }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { file in
                        file.setPath("a.txt")
                            .setSettings(["ATTRIBUTES": ["A2", "B2"]])
                            .setPlatformFilter("macos")
                    }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "copy_files",
                  context: ["\"Target1\" target", "CopyFiles"],
                  differentValues: [
                      .init(context: "a.txt",
                            first: "platformFilter = ios, attributes = [\"A1\", \"B1\"]",
                            second: "platformFilter = macos, attributes = [\"A2\", \"B2\"]"),
                  ]),
        ])
    }

    func testCompare_whenSamePaths() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/a.txt") }
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/a.txt") }
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "copy_files", context: ["\"Target1\" target", "CopyFiles"])])
    }

    func testCompare_whenMultiplePathsToSameFileInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()

        // When
        XCTAssertThrowsError(try subject.compare(first, second, parameters: .all)) { error in
            XCTAssertEqual(error.localizedDescription,
                           "CopyFiles Build Phase in first contains 2 references to the same file (path = a/b.txt)")
        }
    }

    func testCompare_whenMultiplePathsToSameFileInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.frameworks)) { buildPhase in
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                    buildPhase.addBuildFile { $0.setPath("a/b.txt") }
                }
            }
            .projectDescriptor()

        // When
        XCTAssertThrowsError(try subject.compare(first, second, parameters: .all)) { error in
            XCTAssertEqual(error.localizedDescription,
                           "CopyFiles Build Phase in second contains 2 references to the same file (path = a/b.txt)")
        }
    }
}
