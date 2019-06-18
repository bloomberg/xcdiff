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
@testable import XCDiffCommand
import XCTest

final class CommandsRunnerTests: XCTestCase {
    private var sut: CommandRunner!
    private var printer: PrinterMock!
    private var system: SystemMock!
    private let fixtures = Fixtures()

    override func setUp() {
        super.setUp()

        printer = PrinterMock()
        system = SystemMock()

        sut = CommandRunner(printer: printer, system: system)
    }

    func testRun_whenL_listAvailableComparators() {
        // When
        let code = sut.run(with: ["-l"])

        // Then
        XCTAssertEqual("No available comparators\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenSameProject() {
        // Given
        let command = [
            "-p1", fixtures.project.ios_project_1().string,
            "-p2", fixtures.project.ios_project_1().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjects() {
        // Given
        let command = buildCommand()

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsFormatMarkdown() {
        // Given
        let command = buildCommand("-f", "markdown")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsFormatJSON() {
        // Given
        let command = buildCommand("-f", "json")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("[\n\n]\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsUnrecognizedFormat() {
        // Given
        let command = buildCommand("-f", "unrecognized")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("Unrecognized format, use `-f (console | json | markdown)`\n", printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenDifferentProjectsVerbose() {
        // Given
        let command = buildCommand("-v")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsFilterTargets() {
        // Given
        let command = buildCommand("-t", "Target")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsFilterConfigurations() {
        // Given
        let command = buildCommand("-c", "Debug")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenDifferentProjectsFilterTag() {
        // Given
        let command = buildCommand("-g", "targets")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("Unsupported tag \"TARGETS\"\n", printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenDifferentProjectsFilterTags() {
        // Given
        let command = buildCommand("-g", "targets, configurations")

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("Unsupported tag(s) \"CONFIGURATIONS\", \"TARGETS\"\n", printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenP1NotExists() {
        // Given
        let nonExistingPath = fixtures.project.non_existing().string
        let command = [
            "-p1", nonExistingPath,
            "-p2", fixtures.project.ios_project_2().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        let expected = "-p1 \"\(nonExistingPath)\" project does not exist\n"
        XCTAssertEqual(expected, printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenP2NotExists() {
        // Given
        let nonExistingPath = fixtures.project.non_existing().string
        let command = [
            "-p1", fixtures.project.ios_project_1().string,
            "-p2", nonExistingPath,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        let expected = "-p2 \"\(nonExistingPath)\" project does not exist\n"
        XCTAssertEqual(expected, printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenBothNotExist() {
        // Given
        let nonExistingPath = fixtures.project.non_existing().string
        let command = [
            "-p1", nonExistingPath,
            "-p2", nonExistingPath,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        let expected = "-p1 \"\(nonExistingPath)\" project does not exist\n"
        XCTAssertEqual(expected, printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenUnknownArguments() {
        // Given
        let command = ["unknown", "arguments"]

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("unexpected argument unknown; use --help to list available arguments\n", printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenProjectsNotSpecifiedButExistInCurrentDirectory() {
        // Given
        let command: [String] = []
        system.listCurrentDirectoryReturn = [
            fixtures.project.ios_project_1().string,
            fixtures.project.ios_project_2().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual("\n", printer.output)
        XCTAssertEqual(0, code)
    }

    func testRun_whenProjectsNotSpecifiedAndNotExistInCurrentDirectory() {
        // Given
        let command: [String] = []
        let nonExistingPath = fixtures.project.non_existing().string
        system.listCurrentDirectoryReturn = [
            nonExistingPath,
            fixtures.project.ios_project_2().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        let expected = "The project cannot be found at \(nonExistingPath)\n"
        XCTAssertEqual(expected, printer.output)
        XCTAssertEqual(1, code)
    }

    func testRun_whenProjectsNotSpecifiedAndMoreThen2ProjectInCurrentDirectory() {
        // Given
        let command: [String] = []
        let nonExistingPath = fixtures.project.non_existing().string
        system.listCurrentDirectoryReturn = [
            nonExistingPath,
            fixtures.project.ios_project_1().string,
            fixtures.project.ios_project_2().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        let expected = "Could not find 2 projects in the current directory\n"
        XCTAssertEqual(expected, printer.output)
        XCTAssertEqual(1, code)
    }

    // MARK: - Private

    private func buildCommand(p1: String? = nil, p2: String? = nil, _ args: String...) -> [String] {
        return [
            "-p1", p1 ?? fixtures.project.ios_project_1().string,
            "-p2", p2 ?? fixtures.project.ios_project_2().string,
        ] + args
    }
}
