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

final class ConsoleRenderer: Renderer {
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
        let spacing = String(repeating: " ", count: 2 * indent.rawValue)
        let symbol = bullet(indent: indent)
        self.text("\(spacing)\(symbol) \(text)")
    }

    func newLine(_ count: Int = 1) {
        write(String(repeating: "\n", count: count))
    }

    func header(_ text: String, _ header: RendererElement.Header) {
        switch header {
        case .h1:
            write("\n")
            write("=\n")
            write("= \(text)\n")
            write("=\n")
            write("\n")
        case .h2:
            write("\(text)\n")
        case .h3:
            write("\n\(text)\n\n")
        }
    }

    // MARK: - Private

    private func bullet(indent: RendererElement.Indent) -> String {
        switch indent {
        case .zero:
            return "»"
        case .one:
            return "•"
        case .two:
            return "◦"
        }
    }

    private func write(_ string: String) {
        output.write(string)
    }
}
