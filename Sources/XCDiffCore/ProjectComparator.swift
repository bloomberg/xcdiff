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
import XcodeProj

public enum Format: String, RawRepresentable, CaseIterable {
    case console
    case markdown
    case json
}

public struct Result {
    public let success: Bool
    public let output: String
}

public class ProjectComparator {
    private let comparators: [Comparator]
    private let resultRenderer: ResultRenderer
    private let xcodeProjLoader: XcodeProjLoader

    // MARK: - Lifecycle

    init(comparators: [Comparator],
         resultRenderer: ResultRenderer,
         xcodeProjLoader: XcodeProjLoader) {
        self.comparators = comparators
        self.resultRenderer = resultRenderer
        self.xcodeProjLoader = xcodeProjLoader
    }

    // MARK: - Public

    public func compare(_ firstPath: Path,
                        _ secondPath: Path,
                        parameters: ComparatorParameters) throws -> Result {
        let xcodeProj1 = try createProjectDescriptor(with: firstPath)
        let xcodeProj2 = try createProjectDescriptor(with: secondPath)
        let result = try compare(xcodeProj1, xcodeProj2, parameters: parameters)
        let success = result.same()
        let output = try resultRenderer.render(result)
        return Result(success: success, output: output)
    }

    // MARK: - Private

    private func compare(_ first: ProjectDescriptor,
                         _ second: ProjectDescriptor,
                         parameters: ComparatorParameters) throws -> ProjectCompareResult {
        let results = try comparators.flatMap { try $0.compare(first, second, parameters: parameters) }
        return ProjectCompareResult(first: first, second: second, results: results)
    }

    private func createProjectDescriptor(with path: Path) throws -> ProjectDescriptor {
        let xcodeProj = try xcodeProjLoader.load(at: path)
        return ProjectDescriptor(path: path, xcodeProj: xcodeProj)
    }
}

public extension ProjectComparator {
    static func create(comparators: [ComparatorType] = .allAvailableComparators,
                       format: Format,
                       verbose: Bool) -> ProjectComparator {
        let resultRenderer = UniversalResultRenderer(format: format,
                                                     verbose: verbose)
        let xcodeProjLoader = DefaultXcodeProjLoader()
        return ProjectComparator(comparators: comparators.map { $0.comparator() },
                                 resultRenderer: resultRenderer,
                                 xcodeProjLoader: xcodeProjLoader)
    }
}
