//
// Copyright 2022 Bloomberg Finance L.P.
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
final class RunScriptComparatorTests: XCTestCase {
    private var subject: RunScriptComparator!

    override func setUp() {
        subject = RunScriptComparator()
    }

    func testCompare_whenNoRunScripts_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [CompareResult(tag: "run_scripts",
                                              context: ["\"Target1\" target"],
                                              description: nil,
                                              onlyInFirst: [],
                                              onlyInSecond: [],
                                              differentValues: [])])
    }

    func testCompare_whenRunScriptBuildPhaseOnlyInFirst_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1")
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "run_scripts", context: ["\"Target1\" target"])])
    }

    func testCompare_whenMoreThanOneRunScriptBuildPhaseWithTheSameNameInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"Run Script 1\" build phase"]),
            .init(tag: "run_scripts", context: ["\"Target1\" target", "\"Run Script 1\" build phase"],
                  description: "The build phase does not exist in the second project",
                  onlyInFirst: ["Duplicated build phase name"]),
        ])
    }

    func testCompare_whenMoreThanOneRunScriptBuildPhaseWithTheSameNameInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(name: "Run Script 1"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"Run Script 1\" build phase"]),
            .init(tag: "run_scripts", context: ["\"Target1\" target", "\"Run Script 1\" build phase"],
                  description: "The build phase does not exist in the first project",
                  onlyInSecond: ["Duplicated build phase name"]),
        ])
    }

    func testCompare_whenRunScriptBuildPhaseOnlyInSecond_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1")
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [.init(tag: "run_scripts", context: ["\"Target1\" target"])])
    }

    func testCompare_whenSameRunScriptBuildPhaseInBoth_noDifference() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts", context: ["\"Target1\" target", "\"ShellScript\" build phase"]),
        ])
    }

    func testCompare_whenInputPathOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(inputPaths: ["$SRCROOT/somefile.txt"]))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "inputPaths",
                            first: #"["$SRCROOT/somefile.txt"]"#,
                            second: "[]"),
                  ]),
        ])
    }

    func testCompare_whenInputPathOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(inputPaths: ["$SRCROOT/somefile.txt"]))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "inputPaths",
                            first: "[]",
                            second: #"["$SRCROOT/somefile.txt"]"#),
                  ]),
        ])
    }

    func testCompare_whenOutputPathOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(
                    outputPaths: ["$SRCROOT/somefile.txt"]
                ))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "outputPaths",
                            first: #"["$SRCROOT/somefile.txt"]"#,
                            second: "[]"),
                  ]),
        ])
    }

    func testCompare_whenOutputPathOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(
                    outputPaths: ["$SRCROOT/somefile.txt"]
                ))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "outputPaths",
                            first: "[]",
                            second: #"["$SRCROOT/somefile.txt"]"#),
                  ]),
        ])
    }

    func testCompare_whenShellPathIsDifferent() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(shellPath: "/bin/fish"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(shellPath: "/bin/zsh"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "shellPath",
                            first: "/bin/fish",
                            second: "/bin/zsh"),
                  ]),
        ])
    }

    func testCompare_whenShellScriptIsDifferent() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(shellScript: "myscript.py"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(shellScript: "yourscript.py"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "shellScript",
                            first: "myscript.py",
                            second: "yourscript.py"),
                  ]),
        ])
    }

    func testCompare_whenShowEnvVarsInLogIsDifferent() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(showEnvVarsInLog: true))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(showEnvVarsInLog: false))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "showEnvVarsInLog",
                            first: "true",
                            second: "false"),
                  ]),
        ])
    }

    func testCompare_whenAlwaysOutOfDateIsDifferent() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(alwaysOutOfDate: true))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(alwaysOutOfDate: false))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "alwaysOutOfDate",
                            first: "true",
                            second: "false"),
                  ]),
        ])
    }

    func testCompare_whenDependencyFileIsDifferent() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(dependencyFile: "myfile.d"))) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase(dependencyFile: "yourfile.d"))) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "dependencyFile",
                            first: "myfile.d",
                            second: "yourfile.d"),
                  ]),
        ])
    }

    func testCompare_whenInputFileListPathOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { buildPhase in
                    buildPhase.setInputFileListPaths(["$SRCROOT/somefile.txt"])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "inputFileListPaths",
                            first: #"["$SRCROOT/somefile.txt"]"#,
                            second: "nil"),
                  ]),
        ])
    }

    func testCompare_whenInputFileListPathPathOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { buildPhase in
                    buildPhase.setInputFileListPaths(["$SRCROOT/somefile.txt"])
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "inputFileListPaths",
                            first: "nil",
                            second: #"["$SRCROOT/somefile.txt"]"#),
                  ]),
        ])
    }

    func testCompare_whenOutputFileListPathOnlyInFirst() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { buildPhase in
                    buildPhase.setOutputFileListPaths(["$SRCROOT/somefile.txt"])
                }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "outputFileListPaths",
                            first: #"["$SRCROOT/somefile.txt"]"#,
                            second: "nil"),
                  ]),
        ])
    }

    func testCompare_whenOutputFileListPathPathOnlyInSecond() throws {
        // Given
        let first = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { _ in }
            }
            .projectDescriptor()
        let second = project()
            .addTarget(name: "Target1") { target in
                target.addBuildPhase(.shellScripts(RunScriptBuildPhase())) { buildPhase in
                    buildPhase.setOutputFileListPaths(["$SRCROOT/somefile.txt"])
                }
            }
            .projectDescriptor()

        // When
        let actual = try subject.compare(first, second, parameters: .all)

        // Then
        XCTAssertEqual(actual, [
            .init(tag: "run_scripts",
                  context: ["\"Target1\" target", "\"ShellScript\" build phase"],
                  differentValues: [
                      .init(context: "outputFileListPaths",
                            first: "nil",
                            second: #"["$SRCROOT/somefile.txt"]"#),
                  ]),
        ])
    }
}
