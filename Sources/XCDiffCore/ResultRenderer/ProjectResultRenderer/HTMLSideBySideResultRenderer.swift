//
// Copyright 2022 Bloomberg Finance L.P.
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

// swiftlint:disable:next type_body_length
final class HTMLSideBySideResultRenderer: ProjectCompareResultRenderer {
    private let output: AnyOutput<String>
    private let verbose: Bool

    init(output: AnyOutput<String>, verbose: Bool) {
        self.output = output
        self.verbose = verbose
    }

    // MARK: - ResultRenderer

    func render(_ result: ProjectCompareResult) throws {
        output.write(
            makeHtml {
                for resultItem in result.results {
                    render(resultItem)
                }
            }
        )
    }

    // MARK: - Private

    private func render(_ result: CompareResult) -> String {
        guard result.same() == false else {
            return makeSection(cssClass: .success) {
                makeSectionHeader("✅ \(title(from: result))")
            }
        }

        return makeSection(cssClass: .warning) {
            makeSectionHeader("❌ \(title(from: result))")
            if verbose {
                renderDetails(result).joined(separator: "\n")
            }
        }
    }

    @StringBuilder
    private func renderDetails(_ result: CompareResult) -> [String] {
        if let description = result.description {
            makeParagraph(description)
        }
        makeTable {
            for onlyInFirst in result.onlyInFirst {
                makeTableRow(
                    cssClass: .onlyFirstContent,
                    first: onlyInFirst.htmlEscaped(),
                    second: nil
                )
            }

            for onlyInSecond in result.onlyInSecond {
                makeTableRow(
                    cssClass: .onlySecondContent,
                    first: nil,
                    second: onlyInSecond.htmlEscaped()
                )
            }

            // row spacer only to divide the sections if necessary
            if !result.differentValues.isEmpty, !result.onlyInFirst.isEmpty || !result.onlyInSecond.isEmpty {
                makeMergedColumnRow(
                    cssClass: .rowSpacer,
                    text: ""
                )
            }

            for differentValue in result.differentValues {
                makeMergedColumnRow(
                    cssClass: .differentContentKey,
                    text: differentValue.context.htmlEscaped()
                )
                makeTableRow(
                    cssClass: .differentContent,
                    first: differentValue.first.htmlEscaped(),
                    second: differentValue.second.htmlEscaped()
                )
            }
        }
    }

    private func title(from result: CompareResult) -> String {
        let rootContext = result.tag.uppercased()
        let subContext = !result.context.isEmpty ? " > " + result.context.joined(separator: " > ") : ""
        return rootContext + subContext
    }

    private func makeParagraph(_ text: String) -> String {
        """
        <p>
            \(text.htmlEscaped())
        </p>
        """
    }

    private func makeSection(cssClass: CSSClass, @StringBuilder content: () -> [String]) -> String {
        """
        <section class="\(cssClass.rawValue)">
            \(content().joined(separator: "\n"))
        </section>
        """
    }

    private func makeSectionHeader(_ text: String) -> String {
        "<h2>\(text.htmlEscaped())</h2>"
    }

    private func makeTable(@StringBuilder _ content: () -> [String]) -> String {
        """
        <table>
            <thead>
                <tr>
                    <th>First</th>
                    <th>Second</th>
                </tr>
            </thead>
            <tbody>
                \(content().joined(separator: "\n"))
            </tbody>
        </table>
        """
    }

    private func makeTableRow(
        cssClass: CSSClass,
        first: String?,
        second: String?
    ) -> String {
        """
            <tr class="\(cssClass.rawValue)">
                <td>
                    \(first ?? "")
                </td>
                <td>
                    \(second ?? "")
                </td>
            </tr>
        """
    }

    private func makeMergedColumnRow(
        cssClass: CSSClass,
        text: String
    ) -> String {
        """
            <tr class="\(cssClass.rawValue)">
                <td colspan="2">
                    \(text)
                </td>
            </tr>
        """
    }

    // swiftlint:disable:next function_body_length
    private func makeHtml(@StringBuilder body: () -> [String]) -> String {
        """
        <!doctype html>
        <html lang="en">
        <head>
            <meta charset="utf-8">
            <title>xcdiff results</title>
            <meta name="description" content="xcdiff results">
            <meta name="author" content="xcdiff">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                html, body {
                    margin: 0;
                    padding: 0;
                }

                body {
                    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                    font-size: 14px;
                    line-height: 1.5;
                    background-color: #fff;
                    color: #333;
                }

                footer {
                    border-top: 1px #aaa dotted;
                    margin-top: 3em;
                    color: #aaa;
                    font-size: 11px;
                    padding-top: 0.4em;
                    padding-bottom: 0.4em;
                }

                section {
                    margin-top: 1em;
                    padding: 0.1em 1em 0.1em 1em;
                    border-radius: 0.7em;
                }

                ul {
                    margin-top: 0;
                    padding-left: 15px;
                }

                li {
                    font-family: 'Courier New', Courier, monospace;
                }

                h1 {
                    padding: 0.2em 0.5em 0.2em 0.5em;
                    font-size: 24px;
                    font-weight: 300;
                }

                h2 {
                    padding: 0.2em 0.5em 0.2em 0.5em;
                    border-radius: 0.2em;
                    font-size: 14px;
                    font-family: 'Courier New', Courier, monospace;
                }

                h3 {
                    font-size: 12px;
                    padding-left: 0.2em;
                }

                p {
                    margin: 0;
                }

                .container {
                    max-width: 1200px;
                    padding: 10px;
                    margin-right: auto;
                    margin-left: auto;
                }

                .warning {
                    background-color: #fffce3;
                }

                .warning h2 {
                    background-color: #fff2b8;
                }

                .success {
                    background-color: #f1ffe9;
                }

                .content {
                    padding-left: 2em;
                }

                .firstColumn {
                    width: 50%;
                }

                .secondColumn {
                    width: 50%;
                }

                .onlyFirstContent td:nth-child(1) {
                    background-color: #ffdfe6;
                }

                .onlyFirstContent td:nth-child(2) {
                    background-color: #efefef;
                }

                .onlySecondContent td:nth-child(1) {
                    background-color: #efefef;
                }

                .onlySecondContent td:nth-child(2) {
                    background-color: #e3f8d7;
                }

                .differentContentKey {
                    background-color: #f4efbc;
                    color: #56494E;
                    font-weight: bold;
                }

                .differentContent {
                    background-color: #f9f5cb;
                }

                .differentContent td {
                    padding: 2pt 15pt;
                }

                .rowHeading {
                    text-align: center;
                    font-weight: bold;
                }

                .rowSpacer {
                    height: 10pt;
                }

                table {
                    width: 100%;
                }

                table td {
                    width: 50%;
                    padding: 2pt 5pt;
                }

            </style>
        </head>
        <body>
            <div class="container">
                <header>
                    <h1>Δ xcdiff result</h1>
                </header>
                <div class="content">
                    \(body().joined(separator: "\n"))
                </div>
                <footer>
                    Generated by <a href="https://github.com/bloomberg/xcdiff">xcdiff</a>.
                </footer>
            </div>
        </body>
        </html>
        """
    }
}

private extension HTMLSideBySideResultRenderer {
    private enum SectionType {
        case success
        case warning
    }

    private enum CSSClass: String {
        case success
        case warning
        case rowHeading
        case onlyFirstContent
        case onlySecondContent
        case differentContentKey
        case differentContent
        case rowSpacer
    }
}

// MARK: -

@resultBuilder
private struct StringBuilder {
    static func buildBlock(_ component: String...) -> [String] {
        component
    }

    static func buildBlock(_ component: [String]...) -> [String] {
        component.flatMap { $0 }
    }

    static func buildExpression(_ expression: String) -> [String] {
        [expression]
    }

    static func buildArray(_ component: [[String]]) -> [String] {
        component.flatMap { $0 }
    }

    static func buildOptional(_ component: [String]?) -> [String] {
        component ?? []
    }

    static func buildEither(first component: [String]) -> [String] {
        component
    }

    static func buildEither(second component: [String]) -> [String] {
        component
    }
}
