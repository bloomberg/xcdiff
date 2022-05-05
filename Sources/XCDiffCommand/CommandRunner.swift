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

import ArgumentParser
import Foundation
import PathKit
import TSCBasic
import TSCUtility
import XCDiffCore

public final class CommandRunner {
    private let commandType: XCDiffParsableCommand.Type
    private let printer: Printer
    private let fileSystem: FileSystem
    private let allComparators: [ComparatorType] = .allAvailableComparators
    private let defaultComparators: [ComparatorType] = .defaultComparators

    // MARK: - Public

    public init(commandType: XCDiffParsableCommand.Type? = nil,
                printer: Printer? = nil,
                fileSystem: FileSystem? = nil) {
        self.commandType = commandType ?? XCDiffMainCommand.self
        self.printer = printer ?? DefaultPrinter()
        self.fileSystem = fileSystem ?? DefaultFileSystem()
    }

    public func run(with arguments: [String]) -> Int32 {
        do {
            var command = try commandType.parseAsRoot(arguments)
            if let xcdiffCommand = command as? XCDiffParsableCommand {
                return run(with: xcdiffCommand.arguments)
            } else {
                try command.run()
                return complete(commandType: commandType)
            }
        } catch {
            return complete(commandType: commandType, withError: error)
        }
    }

    public func run(with arguments: XCDiffArguments) -> Int32 {
        if arguments.list {
            return runPrintAvailableOperators()
        }

        do {
            return try runPrintCompare(with: arguments)
        } catch {
            return handleError(error)
        }
    }

    private func complete(commandType: ParsableCommand.Type, withError error: Error? = nil) -> Int32 {
        guard let error = error else {
            return ExitCode.success.rawValue
        }

        let exitCode = commandType.exitCode(for: error)
        let fullMessage = commandType.fullMessage(for: error)
        printer.text(fullMessage)

        return exitCode.isSuccess ? ExitCode.success.rawValue : ExitCode.failure.rawValue
    }

    // MARK: - Private

    private func runPrintAvailableOperators() -> Int32 {
        let defaultComparatorsTags = Set([ComparatorType].defaultComparators.map { $0.tag })
        let allAvailableComparators = [ComparatorType].allAvailableComparators
        guard !allAvailableComparators.isEmpty else {
            printer.text("No available comparators")
            return 0
        }
        let nameColumnWidth = 30
        let includedColumnWidth = 10
        let columnSeparator = " | "
        let padding = "  "
        let separatorLength = 2 * padding.count + nameColumnWidth + columnSeparator.count + includedColumnWidth
        let separator = String(repeating: "-", count: separatorLength)

        printer.text("""
        The following list shows all available comparator tags along with their default
        inclusion status when tags aren't explicitly specified.

        """)
        printer.text(padding
            + "COMPARTOR TAG".padding(toLength: nameColumnWidth, withPad: " ", startingAt: 0)
            + columnSeparator
            + "INCLUDED".padding(toLength: includedColumnWidth, withPad: " ", startingAt: 0))
        printer.text(separator)
        let output = allAvailableComparators
            .map { "- "
                + $0.displayName.padding(toLength: nameColumnWidth, withPad: " ", startingAt: 0)
                + columnSeparator
                + (defaultComparatorsTags.contains($0.tag) ? "Yes" : "No")
            }
            .joined(separator: "\n")
        printer.text(output)
        return 0
    }

    private func runPrintCompare(with arguments: XCDiffArguments) throws -> Int32 {
        // Collect required command line arguments
        let targets = targets(from: arguments.target)
        let tags = tags(from: arguments.tag)
        let configurations = configurations(from: arguments.configuration)
        let parameters = ComparatorParameters(targets: targets, configurations: configurations)

        // Set up project comparator
        let (path1, path2) = try getPaths(arguments.path1, arguments.path2)
        let mode = Mode(
            format: arguments.format,
            verbose: arguments.verbose,
            differencesOnly: arguments.differencesOnly
        )
        let projectComparator = ProjectComparatorFactory.create(
            comparators: try allComparators.filter(by: tags),
            mode: mode
        )

        // Run compare
        let result = try projectComparator.compare(path1, path2, parameters: parameters)

        printer.text(result.output)

        return result.success ? 0 : 2
    }

    private func getPaths(_ path1Arg: String?, _ path2Arg: String?) throws -> (Path, Path) {
        if let path1Arg = path1Arg, let path2Arg = path2Arg {
            let path1 = Path(path1Arg)
            let path2 = Path(path2Arg)
            guard path1.exists else {
                throw CommandError.generic("-p1 \"\(path1.absolute().string)\" project does not exist")
            }
            guard path2.exists else {
                throw CommandError.generic("-p2 \"\(path2.absolute().string)\" project does not exist")
            }
            return (path1, path2)
        }

        // check if both paths are undefined, and can find 2 projects
        // in the current directory
        let currentDirectory = try fileSystem.listCurrentDirectory()
            .filter { $0.hasSuffix(".xcodeproj") }
            .sorted()
        if currentDirectory.count == 2, path1Arg == nil, path2Arg == nil {
            return (Path(currentDirectory[0]), Path(currentDirectory[1]))
        }

        // error, one of the paths is not defined, and cannot find 2 projects
        // in the current directory
        throw CommandError.generic("""
        Could not find 2 projects in the current directory,
        use `-p1` and `-p2` to specify the projects paths to compare
        """)
    }

    private func targets(from arg: String?) -> ComparatorParameters.Option<String> {
        arg.map { option(from: $0) } ?? .all
    }

    private func tags(from arg: String?) -> ComparatorParameters.Option<String> {
        arg.map { option(from: $0) } ?? .some(defaultComparators.map { $0.tag })
    }

    private func configurations(from arg: String?) -> ComparatorParameters.Option<String> {
        arg.map { option(from: $0) } ?? .all
    }

    private func handleError(_ error: Error) -> Int32 {
        printer.error(error.localizedDescription)
        return 1
    }

    private func option(from string: String) -> ComparatorParameters.Option<String> {
        let values = string
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        if values.count > 1 {
            return .some(values)
        }
        return .only(string)
    }

    static var formatCases: String {
        let values = XCDiffCore.Format.allCases
            .map { $0.rawValue }
            .sorted()
            .joined(separator: " | ")
        return "(\(values))"
    }

    static var overview: String {
        return """
        Compare Xcode project (.xcodeproj) files.
        """
    }
}

private extension Array where Element == ComparatorType {
    func filter(by option: ComparatorParameters.Option<String>) throws -> [ComparatorType] {
        switch option {
        case .all:
            return self
        case let .only(tag):
            let formattedTag = ComparatorType.displayName(tag)
            let tags = filter { $0.displayName == formattedTag }
            guard !tags.isEmpty else {
                throw CommandError.generic("Unsupported tag \"\(formattedTag)\"")
            }
            return tags
        case let .some(tags):
            let formattedTags = Set(tags.map(ComparatorType.displayName))
            let formattedCompartorsTags = Set(map { $0.displayName })
            let unsupportedTags = formattedTags
                .subtracting(formattedCompartorsTags)
                .sorted()
                .map { "\"\($0)\"" }
            guard unsupportedTags.isEmpty else {
                throw CommandError.generic("Unsupported tag(s) \(unsupportedTags.joined(separator: ", "))")
            }
            return filter { formattedTags.contains($0.displayName) }
        case .none:
            throw CommandError.generic("Comparator required")
        }
    }
}

private extension ComparatorType {
    var displayName: String {
        return ComparatorType.displayName(tag)
    }

    static func displayName(_ tag: String) -> String {
        return tag.uppercased().replacingOccurrences(of: " ", with: "_")
    }
}

enum CommandError: LocalizedError {
    case generic(String)

    public var errorDescription: String? {
        switch self {
        case let .generic(message):
            return message
        }
    }
}

public struct XCDiffArguments: ParsableArguments {
    @Flag(name: .shortAndLong, help: "List all available comparators (tags)")
    var list = false

    @Flag(name: .shortAndLong, help: "Verbose mode")
    var verbose = false

    @Flag(name: .shortAndLong, help: "Differences only in the output")
    var differencesOnly = false

    @Option(
        name: [.long, .customLong("p1", withSingleDash: true)],
        help: "Absolute or relative path to the first Xcode project (.xcodeproj file)"
    )
    var path1: String?

    @Option(
        name: [.long, .customLong("p2", withSingleDash: true)],
        help: "Absolute or relative path to the second Xcode project (.xcodeproj file)"
    )
    var path2: String?

    @Option(name: .shortAndLong, help: "Output format \(CommandRunner.formatCases)")
    var format: XCDiffCore.Format = .console

    @Option(name: .shortAndLong, help: "Target name")
    var target: String?

    @Option(name: [.long, .customShort("g")], help: "Tag name")
    var tag: String?

    @Option(name: .shortAndLong, help: .init("Configuration name", valueName: "c"))
    var configuration: String?

    public init() {}
}

extension XCDiffCore.Format: ExpressibleByArgument {}

public protocol XCDiffParsableCommand: ParsableCommand {
    static var commandName: String { get }
    var arguments: XCDiffArguments { get }
}

public extension XCDiffParsableCommand {
    static var configuration: CommandConfiguration {
        .init(
            commandName: commandName,
            abstract: CommandRunner.overview,
            usage: "[options]",
            version: Constants.version.description
        )
    }
}

struct XCDiffMainCommand: XCDiffParsableCommand {
    static var commandName: String {
        "xcdiff"
    }

    @OptionGroup
    var arguments: XCDiffArguments
}
