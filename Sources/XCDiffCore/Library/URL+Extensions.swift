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

extension URL {
    func relative(to baseURL: URL) -> String? {
        guard isFileURL, baseURL.isFileURL else {
            return nil
        }
        guard self.baseURL == nil, baseURL.baseURL == nil else {
            return nil
        }
        let baseComp = baseURL.standardizedFileURL.pathComponents
        let destinationComp = standardizedFileURL.pathComponents

        var index = 0
        while index < destinationComp.count,
              index < baseComp.count,
              destinationComp[index] == baseComp[index] {
            index += 1
        }

        var relComponents = Array(repeating: "..", count: baseComp.count - index)
        relComponents.append(contentsOf: destinationComp[index...])
        return relComponents.joined(separator: "/")
    }
}
