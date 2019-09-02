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

    // swiftlint:disable:next function_body_length
    func testRun_whenProjectsNotSpecifiedButExistInCurrentDirectory() {
        // Given
        let command: [String] = []
        system.listCurrentDirectoryReturn = [
            fixtures.project.ios_project_1().string,
            fixtures.project.ios_project_1().string,
        ]

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual(printer.output, """
        ✅ FILE_REFERENCES
        ✅ TARGETS > NATIVE targets
        ✅ TARGETS > AGGREGATE targets
        ✅ HEADERS > "Project" target
        ✅ HEADERS > "ProjectFramework" target
        ✅ HEADERS > "ProjectTests" target
        ✅ HEADERS > "ProjectUITests" target
        ✅ SOURCES > "Project" target
        ✅ SOURCES > "ProjectFramework" target
        ✅ SOURCES > "ProjectTests" target
        ✅ SOURCES > "ProjectUITests" target
        ✅ RESOURCES > "Project" target
        ✅ RESOURCES > "ProjectFramework" target
        ✅ RESOURCES > "ProjectTests" target
        ✅ RESOURCES > "ProjectUITests" target
        ✅ CONFIGURATIONS > Root project
        ✅ SETTINGS > Root project > "Debug" configuration > Base configuration
        ✅ SETTINGS > Root project > "Debug" configuration > Values
        ✅ SETTINGS > Root project > "Release" configuration > Base configuration
        ✅ SETTINGS > Root project > "Release" configuration > Values
        ✅ SETTINGS > "Project" target > "Debug" configuration > Base configuration
        ✅ SETTINGS > "Project" target > "Debug" configuration > Values
        ✅ SETTINGS > "Project" target > "Release" configuration > Base configuration
        ✅ SETTINGS > "Project" target > "Release" configuration > Values
        ✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration
        ✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values
        ✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration
        ✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Values
        ✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration
        ✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values
        ✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration
        ✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values
        ✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration
        ✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
        ✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
        ✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Values
        ✅ SOURCE_TREE > Root project


        """)
        XCTAssertEqual(code, 0)
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
        let expected = "ERROR: The project cannot be found at \(nonExistingPath)\n"
        XCTAssertEqual(printer.output, expected)
        XCTAssertEqual(code, 1)
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
        let expected = "ERROR: Could not find 2 projects in the current directory\n"
        XCTAssertEqual(printer.output, expected)
        XCTAssertEqual(code, 1)
    }

    func testRun_whenVersion() {
        // Given
        let command = ["--version"]

        // When
        let code = sut.run(with: command)

        // Then
        XCTAssertEqual(printer.output, "0.1.1+debug.local\n")
        XCTAssertEqual(code, 0)
    }

    // MARK: - Private

    private func buildCommand(p1: String? = nil, p2: String? = nil, _ args: String...) -> [String] {
        return [
            "-p1", p1 ?? fixtures.project.ios_project_1().string,
            "-p2", p2 ?? fixtures.project.ios_project_2().string,
        ] + args
    }
}
