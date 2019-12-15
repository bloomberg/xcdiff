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

    func testCompare_whenSameBuildPhasesButDifferentOrder() throws {
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
                target.addBuildPhase(.resources) { $0.addBuildFile { $0.setPath("C1.jpeg") } }
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.headers) { $0.addBuildFile { $0.setPath("A1.h") } }
                target.addBuildPhase(.sources) { $0.addBuildFile { $0.setPath("B1.swift") } }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "build_phases",
                  context: ["\"Target1\" target"],
                  differentValues: [
                      .init(context: "Build Phase 1",
                            first: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false",
                            second: "name = Resources, type = Resources, runOnlyForDeploymentPostprocessing = false"),
                      .init(context: "Build Phase 2",
                            first: "name = Headers, type = Headers, runOnlyForDeploymentPostprocessing = false",
                            second: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false"),
                      .init(context: "Build Phase 3",
                            first: "name = Sources, type = Sources, runOnlyForDeploymentPostprocessing = false",
                            second: "name = Headers, type = Headers, runOnlyForDeploymentPostprocessing = false"),
                      .init(context: "Build Phase 4",
                            first: "name = Resources, type = Resources, runOnlyForDeploymentPostprocessing = false",
                            second: "name = Sources, type = Sources, runOnlyForDeploymentPostprocessing = false"),
                  ]),
        ])
    }

    func testCompare_whenMissingCopyFilesBuildPhase() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1", productType: .application) { target in
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.copyFiles(.plugins)) { _ in }
                target.addBuildPhase(.copyFiles(.init(name: "Custom Copy Files",
                                                      runOnlyForDeploymentPostprocessing: false,
                                                      dskSubfolderSpec: nil,
                                                      dstPath: nil))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1", productType: .application) { target in
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
                      .init(context: "Build Phase 2",
                            first: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false",
                            second: nil),
                      .init(context: "Build Phase 3",
                            first:
                            "name = Custom Copy Files, type = CopyFiles, runOnlyForDeploymentPostprocessing = false",
                            second: nil),
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
                      .init(context: "Build Phase 1",
                            first: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false, "
                                + "inputFileListPaths = [\"input1.txt\", \"input2.txt\", \"input3.txt\"]",
                            second: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false, "
                                + "inputFileListPaths = [\"input1.txt\"]"),
                      .init(context: "Build Phase 2",
                            first: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false, "
                                + "outputFileListPaths = [\"output1.txt\", \"output2.txt\", \"output3.txt\"]",
                            second: "name = CopyFiles, type = CopyFiles, runOnlyForDeploymentPostprocessing = false, "
                                + "outputFileListPaths = [\"output1.txt\"]"),
                  ]),
        ])
    }
}
