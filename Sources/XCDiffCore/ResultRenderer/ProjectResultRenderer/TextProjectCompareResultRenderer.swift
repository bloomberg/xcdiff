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

final class TextProjectCompareResultRenderer: ProjectCompareResultRenderer {
    private let renderer: Renderer
    private let verbose: Bool

    init(renderer: Renderer, verbose: Bool) {
        self.renderer = renderer
        self.verbose = verbose
    }

    func render(_ result: ProjectCompareResult) {
        renderer.begin()
        result.results.forEach(render)
        renderer.end()
    }

    // MARK: - Private

    private func render(_ result: CompareResult) {
        guard result.same() == false else {
            renderer.section(.success) {
                renderer.header("✅ \(title(from: result))", .h2)
            }
            return
        }

        renderer.section(.warning) {
            renderer.header("❌ \(title(from: result))", .h2)
            guard verbose else {
                return
            }

            // render description
            if let description = result.description {
                renderer.text(description)
            }

            // render only in first
            let onlyInFirst = result.onlyInFirst
            if !onlyInFirst.isEmpty {
                renderer.header("⚠️  Only in first (\(onlyInFirst.count)):", .h3)
                renderer.section(.content) {
                    renderer.list {
                        onlyInFirst.forEach {
                            renderer.item($0)
                        }
                    }
                }
            }

            // render only in second
            let onlyInSecond = result.onlyInSecond
            if !onlyInSecond.isEmpty {
                renderer.header("⚠️  Only in second (\(onlyInSecond.count)):", .h3)
                renderer.section(.content) {
                    renderer.list {
                        onlyInSecond.forEach {
                            renderer.item($0)
                        }
                    }
                }
            }

            // render different values
            let differentValues = result.differentValues
            if !differentValues.isEmpty {
                renderer.header("⚠️  Value mismatch (\(differentValues.count)):", .h3)
                renderer.section(.content) {
                    renderer.list {
                        differentValues.forEach { item in
                            renderer.item {
                                renderer.pre(item.context)
                                renderer.list {
                                    renderer.item(item.first)
                                    renderer.item(item.second)
                                }
                            }
                        }
                    }
                }
            }

            // added for compatibility with the old renderer
            if differentValues.isEmpty {
                renderer.line(1)
            }
        }
    }

    private func title(from result: CompareResult) -> String {
        let rootContext = result.tag.uppercased()
        let subContext = !result.context.isEmpty ? " > " + result.context.joined(separator: " > ") : ""
        return rootContext + subContext
    }
}
