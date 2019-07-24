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
import PathKit
import XCDiffCommand
import XCTest

final class CommandBasedTests: XCTestCase {
    private let fixtures = Fixtures()

    func testCommands() {
        let scenarios = fixtures.project.scenarios()
        let commands = scenarios.map(createCommand)

        commands.forEach { command in
            print("Checking '\(command.command)'.")
            let printer = PrinterMock()
            let sut = CommandRunner(printer: printer)
            let exitCode = sut.run(with: command.asArray())

            XCTAssertEqual(printer.output, command.expectedOutput,
                           "'\(command.command)' didn't produce expected output.")
            XCTAssertEqual(exitCode, command.expectedExitCode,
                           "'\(command.command)' didn't produce expected exit code.")
        }
    }

    // MARK: - Private

    private func createCommand(from path: Path) -> Command {
        let components = path.lastComponent.capturedGroups(withRegex: "^(.*)\\.(.*)\\.(.*)$")

        guard components.count == 3 else {
            fatalError("Scenario at \"\(path)\" has incorrect filename, use <command>.<expected_exit_code>.txt")
        }

        let command: String = ProjectFixtures.Project.allCases
            .map { (key: "{\($0)}", path: fixtures.project.path(to: $0).string) }
            .reduce(components[0]) { acc, tuple in acc.replacingOccurrences(of: tuple.key, with: tuple.path) }

        guard let expectedExitCode = UInt(components[1]) else {
            fatalError("Scenario at \"\(path)\" exit code cannot be converted to UInt")
        }

        guard let expectedOutput = try? String(contentsOfFile: path.string) else {
            fatalError("Scenario at \"\(path)\" output cannot be read from the file")
        }

        return Command(command: command,
                       expectedExitCode: expectedExitCode,
                       expectedOutput: expectedOutput)
    }
}

private struct Command {
    let command: String
    let expectedExitCode: UInt
    let expectedOutput: String

    func asArray() -> [String] {
        return command.split(separator: " ").map { String($0) }
    }
}

private extension String {
    func capturedGroups(withRegex pattern: String) -> [String] {
        let regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return []
        }

        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: count))
        guard let match = matches.first else {
            return []
        }

        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else {
            return []
        }

        return (1 ... lastRangeIndex).map { index in
            let capturedGroupIndex = match.range(at: index)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            return matchedString
        }
    }
}
