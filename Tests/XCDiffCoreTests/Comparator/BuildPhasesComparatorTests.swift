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

// swiftlint:disable:next type_body_length
final class BuildPhasesComparatorTests: XCTestCase {
    private var subject: BuildPhasesComparator!

    override func setUp() {
        subject = BuildPhasesComparator()
    }

    func testCompare_whenEqualBuildPhases() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A1.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B1.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C1.jpeg") } }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "build_phases", context: ["\"Target1\" target"])])
    }

    func testCompare_whenOneBuildPhaseOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  onlyInFirst: ["Headers"]),
        ])
    }

    func testCompare_whenOneBuildPhaseOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  onlyInSecond: ["Headers"]),
        ])
    }

    func testCompare_whenTwoBuildPhasesOfSameTypeOnlyInFirstSameOrder() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 1"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 2"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 3"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 1"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  onlyInFirst: ["Shell 2 (runScript)", "Shell 3 (runScript)"]),
        ])
    }

    func testCompare_whenTwoBuildPhasesOfSameTypeOnlyInFirstDifferentOrder() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 2"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 3"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 1"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell 1"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  onlyInFirst: ["Shell 2 (runScript)", "Shell 3 (runScript)"]),
        ])
    }

    func testCompare_whenSameBuildPhaseDifferentName() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell A"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Shell B"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  onlyInFirst: ["Shell A (runScript)"],
                  onlyInSecond: ["Shell B (runScript)"]),
        ])
    }

    func testCompare_whenSameBuildPhasesButDifferentOrder() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A.h") } }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B.swift") } }
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C.jpeg") } }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  differentValues: [
                      .init(context: "Different order",
                            first: "CopyFiles, Sources, Resources, Headers",
                            second: "CopyFiles, Headers, Sources, Resources"),
                  ]),
        ])
    }

    func testCompare_whenDifferentOutputInputFileListPaths() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setInputFileListPaths(["input1.txt", "input2.txt", "input3.txt"])
                }
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setOutputFileListPaths(["output1.txt", "output2.txt", "output3.txt"])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setInputFileListPaths(["input1.txt"])
                }
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setOutputFileListPaths(["output1.txt"])
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  differentValues: [
                      .init(context: "Different properties in \"CopyFiles\"",
                            first: "inputFileListPaths = [\"input1.txt\", \"input2.txt\", \"input3.txt\"]",
                            second: "inputFileListPaths = [\"input1.txt\"]"),
                      .init(context: "Different properties in \"CopyFiles\"",
                            first: "outputFileListPaths = [\"output1.txt\", \"output2.txt\", \"output3.txt\"]",
                            second: "outputFileListPaths = [\"output1.txt\"]"),
                  ]),
        ])
    }

    func testCompare_whenDifferentOutputInputFileListPathsWithNils() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setInputFileListPaths(["input1.txt", "input2.txt", "input3.txt"])
                }
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setOutputFileListPaths(["output1.txt", "output2.txt", "output3.txt"])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  differentValues: [
                      .init(context: "Different properties in \"CopyFiles\"",
                            first: "inputFileListPaths = [\"input1.txt\", \"input2.txt\", \"input3.txt\"]",
                            second: "inputFileListPaths = nil"),
                      .init(context: "Different properties in \"CopyFiles\"",
                            first: "outputFileListPaths = [\"output1.txt\", \"output2.txt\", \"output3.txt\"]",
                            second: "outputFileListPaths = nil"),
                  ]),
        ])
    }

    func testCompare_whenEmptyEqualsNilInputAndOutpulFileListPaths() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setInputFileListPaths([])
                }
                target.addBuildPhase(.copyFiles(.plugins)) {
                    $0.setOutputFileListPaths([])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases", context: ["\"Target1\" target"]),
        ])
    }

    func testCompare_whenDifferentRunOnlyForDeploymentPostprocessing() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copyBuildPhase = CopyFilesBuildPhase(dstSubfolderSpec: .plugins)
                target.addBuildPhase(.copyFiles(copyBuildPhase)) { buildPhase in
                    buildPhase.setRunOnlyForDeploymentPostprocessing(true)
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
                let copyBuildPhase = CopyFilesBuildPhase(dstSubfolderSpec: .plugins)
                target.addBuildPhase(.copyFiles(copyBuildPhase)) { buildPhase in
                    buildPhase.setRunOnlyForDeploymentPostprocessing(false)
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  differentValues: [
                      .init(context: "Different properties in \"CopyFiles\"",
                            first: "runOnlyForDeploymentPostprocessing = true",
                            second: "runOnlyForDeploymentPostprocessing = false"),
                  ]),
        ])
    }
}
