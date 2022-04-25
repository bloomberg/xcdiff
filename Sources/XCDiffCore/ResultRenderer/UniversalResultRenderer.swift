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

final class UniversalResultRenderer: ResultRenderer {
    private let format: Format
    private let verbose: Bool

    // MARK: - Lifecycle

    init(format: Format, verbose: Bool) {
        self.format = format
        self.verbose = verbose
    }

    // MARK: - ResultRenderer

    func render(_ result: ProjectCompareResult) throws -> String {
        let outputBuffer = StringOutputBuffer()
        let renderer = createResultRenderer(with: outputBuffer.any())
        try renderer.render(result)
        return outputBuffer.flush()
    }

    // MARK: - Private

    private func createResultRenderer(with outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        switch format {
        case .console:
            return createConsoleRenderer(outputBuffer: outputBuffer)
        case .markdown:
            return createMarkdownRenderer(outputBuffer: outputBuffer)
        case .json:
            return createJSONRenderer(outputBuffer: outputBuffer)
        case .html:
            return createHTMLRenderer(outputBuffer: outputBuffer)
        case .htmlSideBySide:
            return createHTMLSideBySideRenderer(outputBuffer: outputBuffer)
        }
    }

    private func createConsoleRenderer(outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        return TextProjectCompareResultRenderer(renderer: ConsoleRenderer(output: outputBuffer),
                                                verbose: verbose)
    }

    private func createMarkdownRenderer(outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        return TextProjectCompareResultRenderer(renderer: MarkdownRenderer(output: outputBuffer),
                                                verbose: verbose)
    }

    private func createJSONRenderer(outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        return JSONProjectCompareResultRenderer(output: outputBuffer,
                                                verbose: verbose)
    }

    private func createHTMLRenderer(outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        return TextProjectCompareResultRenderer(renderer: HTMLRenderer(output: outputBuffer),
                                                verbose: verbose)
    }

    private func createHTMLSideBySideRenderer(outputBuffer: AnyOutput<String>) -> ProjectCompareResultRenderer {
        return HTMLSideBySideResultRenderer(output: outputBuffer, verbose: verbose)
    }
}
