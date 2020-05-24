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

final class MarkdownRenderer: Renderer {
    private let output: AnyOutput<String>

    init(output: AnyOutput<String>) {
        self.output = output
    }

    func text(_ text: String) {
        write("\(text)\n")
    }

    func list(_ element: RendererElement.List) {
        switch element {
        case .begin:
            return
        case .end:
            newLine(1)
        }
    }

    func bullet(_ text: String, indent: RendererElement.Indent) {
        write("\(String(repeating: " ", count: 2 * indent.rawValue))- `\(text)`\n")
    }

    func newLine(_ count: Int) {
        write("\(String(repeating: "\n", count: count))")
    }

    func header(_ text: String, _ header: RendererElement.Header) {
        write("\n\(String(repeating: "#", count: header.rawValue)) \(text)\n\n")
    }

    // MARK: - Private

    private func write(_ string: String) {
        output.write(string)
    }
}

final class MarkdownRenderer2: Renderer2 {
    private let output: AnyOutput<String>
    private var indent: Int = 0

    init(output: AnyOutput<String>) {
        self.output = output
    }

    func begin() {
        // nothing
    }

    func end() {
        // nothing
    }

    func section(_ style: RendererElement.Style, _ content: () -> Void) {
        content()
    }

    func header(_ text: String, _ header: RendererElement.Header) {
        write("\n\(String(repeating: "#", count: header.rawValue)) \(text)\n\n")
    }

    func text(_ text: String) {
        write("\(text)\n")
    }

    func list(_ content: () -> Void) {
        indent += 1
        content()
        indent -= 1
    }

    func item(_ text: String) {
        item {
            write("`\(text)`")
        }
    }

    func item(_ content: () -> Void) {
        write("\(String(repeating: " ", count: 2 * indent))- ")
        content()
        write("\n")
    }

    func line(_ count: Int) {
        write("\(String(repeating: "\n", count: count))")
    }

    // MARK: - Private

    private func write(_ string: String) {
        output.write(string)
    }
}
