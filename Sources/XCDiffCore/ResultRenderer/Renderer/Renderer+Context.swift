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

extension Renderer {
    func onlyInFirstHeader(count: Int? = nil) {
        header("⚠️  Only in first\(string(from: count)):", .h3)
    }

    func onlyInSecondHeader(count: Int? = nil) {
        header("⚠️  Only in second\(string(from: count)):", .h3)
    }

    func differentValuesHeader(count: Int? = nil) {
        header("⚠️  Value mismatch\(string(from: count)):", .h3)
    }

    func successHeader(_ text: String) {
        header("✅ \(text)", .h2)
    }

    func errorHeader(_ text: String) {
        header("❌ \(text)", .h2)
    }

    // MARK: - Private

    private func string(from count: Int?) -> String {
        guard let count = count else {
            return ""
        }
        return " (\(count))"
    }
}
