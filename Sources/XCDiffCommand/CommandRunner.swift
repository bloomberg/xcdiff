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

import Basic
import Foundation
import PathKit
import SPMUtility
import XCDiffCore

public final class CommandRunner {
    private let printer: Printer
    private let fileSystem: FileSystem
    private let parser: ArgumentParser
    private let versionOption: OptionArgument<Bool>
    private let path1Option: OptionArgument<String>
    private let path2Option: OptionArgument<String>
    private let formatOption: OptionArgument<String>
    private let targetOption: OptionArgument<String>
    private let tagOption: OptionArgument<String>
    private let configurationOption: OptionArgument<String>
    private let verboseOption: OptionArgument<Bool>
    private let differencesOnlyOption: OptionArgument<Bool>
    private let listOption: OptionArgument<Bool>
    private let command: String
    private let allComparators: [ComparatorType] = .allAvailableComparators
    private let defaultComparators: [ComparatorType] = .defaultComparators

    // MARK: - Public

    // swiftlint:disable:next function_body_length
    public init(command: String = "xcdiff",
                printer: Printer? = nil,
                fileSystem: FileSystem? = nil,
                externalParser: ArgumentParser? = nil) {
        self.command = command
        self.printer = printer ?? DefaultPrinter()
        self.fileSystem = fileSystem ?? DefaultFileSystem()

        if let externalParser = externalParser {
            parser = externalParser.add(subparser: command,
                                        overview: CommandRunner.overview)
        } else {
            parser = ArgumentParser(commandName: command,
                                    usage: "[options]",
                                    overview: CommandRunner.overview)
        }

        versionOption = parser.add(option: "--version",
                                   kind: Bool.self,
                                   usage: "Show \(command) version")
        path1Option = parser.add(option: "--path1",
                                 shortName: "-p1",
                                 kind: String.self,
                                 usage: "Absolute or relative path to the first Xcode project (.xcodeproj file)",
                                 completion: nil)
        path2Option = parser.add(option: "--path2",
                                 shortName: "-p2",
                                 kind: String.self,
                                 usage: "Absolute or relative path to the second Xcode project (.xcodeproj file)",
                                 completion: nil)
        formatOption = parser.add(option: "--format",
                                  shortName: "-f",
                                  kind: String.self,
                                  usage: "Output format \(CommandRunner.formatCases)")
        targetOption = parser.add(option: "--target",
                                  shortName: "-t",
                                  kind: String.self,
                                  usage: "Target name")
        tagOption = parser.add(option: "--tag",
                               shortName: "-g",
                               kind: String.self,
                               usage: "Tag name")
        configurationOption = parser.add(option: "--configuration",
                                         shortName: "-c",
                                         kind: String.self,
                                         usage: "Configuration name")
        verboseOption = parser.add(option: "--verbose",
                                   shortName: "-v",
                                   kind: Bool.self,
                                   usage: "Verbose mode")
        differencesOnlyOption = parser.add(option: "--differences-only",
                                           shortName: "-d",
                                           kind: Bool.self,
                                           usage: "Differences only in the output")
        listOption = parser.add(option: "--list",
                                shortName: "-l",
                                kind: Bool.self,
                                usage: "List all available comparators (tags)")
    }

    public func run(with arguments: ArgumentParser.Result) -> Int32 {
        // Collect required command line arguments
        let version = getVersion(from: arguments)
        let list = getList(from: arguments)

        // Check if version requested
        if version {
            return runPrintVersion()
        }

        // Check if list requested
        if list {
            return runPrintAvailableOperators()
        }

        // Run compare
        do {
            return try runPrintCompare(with: arguments)
        } catch {
            return handleError(error)
        }
    }

    public func run(with rawArguments: [String]) -> Int32 {
        do {
            let arguments = try parseArguments(rawArguments)
            return run(with: arguments)
        } catch {
            return handleError(error)
        }
    }

    // MARK: - Private

    private func runPrintVersion() -> Int32 {
        printer.text(Constants.version.description)
        return 0
    }

    private func runPrintAvailableOperators() -> Int32 {
        let comparators = [ComparatorType].allAvailableComparators
        guard !comparators.isEmpty else {
            printer.text("No available comparators")
            return 0
        }
        let output = "- " + comparators
            .map { $0.displayName }
            .joined(separator: "\n- ")
        printer.text(output)
        return 0
    }

    private func runPrintCompare(with arguments: ArgumentParser.Result) throws -> Int32 {
        // Collect required command line arguments
        let format = try getFormat(from: arguments)
        let targets = getTargets(from: arguments)
        let tags = getTags(from: arguments)
        let configurations = getConfigurations(from: arguments)
        let verbose = getVerbose(from: arguments)
        let differencesOnly = getDifferencesOnly(from: arguments)
        let parameters = ComparatorParameters(targets: targets,
                                              configurations: configurations)

        // Set up project comparator
        let (path1, path2) = try getPaths(from: arguments)
        let mode = Mode(format: format, verbose: verbose, differencesOnly: differencesOnly)
        let projectComparator = ProjectComparatorFactory.create(comparators: try allComparators.filter(by: tags),
                                                                mode: mode)

        // Run compare
        let result = try projectComparator.compare(path1, path2, parameters: parameters)

        printer.text(result.output)

        return result.success ? 0 : 2
    }

    private func parseArguments(_ arguments: [String]) throws -> ArgumentParser.Result {
        return try parser.parse(arguments)
    }

    private func getPaths(from arguments: ArgumentParser.Result) throws -> (Path, Path) {
        let path1Arg = arguments.get(path1Option)
        let path2Arg = arguments.get(path2Option)

        // check if both paths are defined
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

    private func getFormat(from arguments: ArgumentParser.Result) throws -> XCDiffCore.Format {
        guard let formatString = arguments.get(formatOption) else {
            return .console
        }

        guard let format = Format(rawValue: formatString) else {
            throw CommandError.generic("Unrecognized format, use `-f \(CommandRunner.formatCases)`")
        }

        return format
    }

    private func getTargets(from arguments: ArgumentParser.Result) -> ComparatorParameters.Option<String> {
        guard let targets = arguments.get(targetOption) else {
            return .all
        }
        return option(from: targets)
    }

    private func getTags(from arguments: ArgumentParser.Result) -> ComparatorParameters.Option<String> {
        guard let tags = arguments.get(tagOption) else {
            return .some(defaultComparators.map { $0.tag.rawValue })
        }
        return option(from: tags)
    }

    private func getConfigurations(from arguments: ArgumentParser.Result) -> ComparatorParameters.Option<String> {
        guard let configurations = arguments.get(configurationOption) else {
            return .all
        }
        return option(from: configurations)
    }

    private func getVerbose(from arguments: ArgumentParser.Result) -> Bool {
        guard let verbose = arguments.get(verboseOption) else {
            return false
        }
        return verbose
    }

    private func getDifferencesOnly(from arguments: ArgumentParser.Result) -> Bool {
        guard let differencesOnly = arguments.get(differencesOnlyOption) else {
            return false
        }
        return differencesOnly
    }

    private func getList(from arguments: ArgumentParser.Result) -> Bool {
        guard let list = arguments.get(listOption) else {
            return false
        }
        return list
    }

    private func getVersion(from arguments: ArgumentParser.Result) -> Bool {
        return arguments.get(versionOption) ?? false
    }

    private func printUsage() {
        parser.printUsage(on: stdoutStream)
    }

    private func handleError(_ error: Error) -> Int32 {
        let parsedError = parseError(error)
        printer.error(parsedError.message)
        return parsedError.code
    }

    private func parseError(_ error: Error) -> (code: Int32, message: String) {
        switch error {
        case let error as ArgumentParserError:
            return (1, error.description)
        default:
            return (1, error.localizedDescription)
        }
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

    private static var formatCases: String {
        let values = XCDiffCore.Format.allCases
            .map { $0.rawValue }
            .sorted()
            .joined(separator: " | ")
        return "(\(values))"
    }

    private static var overview: String {
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
            let formattedTag = ComparatorType.displayName(ComparatorTag(rawValue: tag))
            let tags = filter { $0.displayName == formattedTag }
            guard !tags.isEmpty else {
                throw CommandError.generic("Unsupported tag \"\(formattedTag)\"")
            }
            return tags
        case let .some(tags):
            let formattedTags = Set(tags.map { ComparatorTag(rawValue: $0) }.map(ComparatorType.displayName))
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

    static func displayName(_ tag: ComparatorTag) -> String {
        return tag.rawValue.uppercased().replacingOccurrences(of: " ", with: "_")
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
