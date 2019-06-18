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

final class JSONProjectCompareResultRenderer: ProjectCompareResultRenderer {
    private let output: AnyOutput<String>
    private let verbose: Bool
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()

    init(output: AnyOutput<String>, verbose: Bool) {
        self.output = output
        self.verbose = verbose
    }

    func render(_ result: ProjectCompareResult) throws {
        let data = try encoder.encode(result)
        guard let string = String(data: data, encoding: .utf8) else {
            throw ComparatorError.generic("Cannot convert the result into JSON string")
        }
        output.write(string)
    }
}
