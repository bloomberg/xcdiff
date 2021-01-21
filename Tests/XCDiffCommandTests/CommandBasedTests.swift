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
        let commands = scenarios.map(createCommandFromMarkdown)

        commands.forEach { command in
            print("Checking '\(command)'.")
            let printer = PrinterMock()
            let subject = CommandRunner(printer: printer)
            let exitCode = subject.run(with: command.command)

            //
            // Note: In the event this test fails, it means that the produced output from xcdiff
            // now mismatches the snapshotes previously captured.
            //
            // Snapshots can be re-generated via running `make regenerate_command_snapshots`.
            //
            XCTAssertEqual(printer.output, command.expectedOutput,
                           "'\(command)' didn't produce expected output.")
            XCTAssertEqual(exitCode, command.expectedExitCode,
                           "'\(command)' didn't produce expected exit code.")
        }
    }

    // MARK: - Private

    private func createCommandFromMarkdown(from path: Path) -> Command {
        guard let content = try? String(contentsOfFile: path.string) else {
            fatalError("Scenario at \"\(path)\" output cannot be read from the file.")
        }
        let scanner = Scanner(string: content)
        scanner.charactersToBeSkipped = CharacterSet() // newlines are important

        // # Command
        var commandJson: NSString?

        scanner.scanStringOrFail("# Command", into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanStringOrFail("```", into: nil)
        scanner.scanUpToCharactersOrFail(from: .newlines, into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanUpToCharactersOrFail(from: .newlines, into: &commandJson)
        scanner.scanNewLineOrFail()
        scanner.scanStringOrFail("```", into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanNewLineOrFail()

        // # Expected exit code
        var expectedExitCode: Int32 = .min

        scanner.scanStringOrFail("# Expected exit code", into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanInt32OrFail(&expectedExitCode)
        scanner.scanNewLineOrFail()
        scanner.scanNewLineOrFail()

        // # Expected output
        var expectedOutput: NSString?

        scanner.scanStringOrFail("# Expected output", into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanStringOrFail("```", into: nil)
        scanner.scanNewLineOrFail()
        scanner.scanUpToOrFail("\n```", into: &expectedOutput)

        guard let expectedOutputString = expectedOutput as String? else {
            fatalError()
        }

        return Command(filename: path.lastComponent,
                       command: decodeJsonCommand(from: commandJson, at: path),
                       expectedExitCode: expectedExitCode,
                       expectedOutput: expectedOutputString)
    }

    private func decodeJsonCommand(from commandJson: NSString?, at path: Path) -> [String] {
        guard let jsonString = commandJson as String? else {
            fatalError()
        }
        guard let commandData = jsonString.data(using: .utf8) else {
            fatalError("Scenario at \"\(path)\" command cannot be parsed, cannot convert first line to Data type.")
        }
        guard let rawCommand = try? JSONDecoder().decode([String].self, from: commandData) else {
            fatalError("Scenario at \"\(path)\" command cannot be parsed, make sure you use JSON array.")
        }
        let projectPathsTuples = ProjectFixtures.Project.allCases
            .map { (key: "{\($0)}", path: fixtures.project.path(to: $0).string) }
        let projectPaths = Dictionary(uniqueKeysWithValues: projectPathsTuples)
        let command = rawCommand.map { projectPaths[$0] ?? $0 }
        return command
    }
}

private extension Scanner {
    func scanStringOrFail(_ string: String, into result: AutoreleasingUnsafeMutablePointer<NSString?>?) {
        if #available(OSX 10.15, *) {
            guard let value = scanString(string) else {
                fatalError("Missing token: \(string)")
            }
            result?.pointee = value as NSString
        } else {
            guard scanString(string, into: result) else {
                fatalError("Missing token: \(string)")
            }
        }
    }

    func scanUpToCharactersOrFail(from characterSet: CharacterSet,
                                  into result: AutoreleasingUnsafeMutablePointer<NSString?>?) {
        if #available(OSX 10.15, *) {
            guard let value = scanUpToCharacters(from: characterSet) else {
                fatalError("Missing token from character set: \(characterSet)")
            }
            result?.pointee = value as NSString
        } else {
            guard scanUpToCharacters(from: characterSet, into: result) else {
                fatalError("Missing token from character set: \(characterSet)")
            }
        }
    }

    func scanUpToOrFail(_ string: String,
                        into result: AutoreleasingUnsafeMutablePointer<NSString?>?) {
        if #available(OSX 10.15, *) {
            guard let value = scanUpToString(string) else {
                fatalError("Missing token: \(string)")
            }
            result?.pointee = value as NSString
        } else {
            guard scanUpTo(string, into: result) else {
                fatalError("Missing token: \(string)")
            }
        }
    }

    func scanInt32OrFail(_ result: UnsafeMutablePointer<Int32>?) {
        if #available(OSX 10.15, *) {
            guard let value = scanInt32() else {
                fatalError("Missing Int32")
            }
            result?.pointee = value
        } else {
            guard scanInt32(result) else {
                fatalError("Missing Int32")
            }
        }
    }

    func scanNewLineOrFail() {
        scanStringOrFail("\n", into: nil)
    }
}

private struct Command: CustomStringConvertible {
    let filename: String
    let command: [String]
    let expectedExitCode: Int32
    let expectedOutput: String

    var description: String {
        return "\(filename)"
    }
}

private extension String {
    func lines() -> [String] {
        var lines: [String] = []
        enumerateLines { string, _ in
            lines.append(string)
        }
        return lines
    }
}
