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

struct RendererElement {
    enum Header: Int {
        case h1 = 1
        case h2
        case h3
    }

    enum Style {
        case content
        case success
        case warning
    }
}

protocol Renderer {
    func begin()
    func end()
    func section(_ style: RendererElement.Style, _ content: () -> Void)
    func header(_ text: String, _ header: RendererElement.Header)
    func text(_ text: String)
    func pre(_ text: String)
    func list(_ content: () -> Void)
    func item(_ text: String)
    func item(_ content: () -> Void)
    func line(_ count: Int)
}
