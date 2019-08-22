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
import XcodeProj

final class PBXBuildConfigurationBuilder {
    private let name: String
    private var buildSettings: [String: Any] = [:]
    private var baseConfiguration: PBXFileReference?

    init(name: String) {
        self.name = name
    }

    @discardableResult
    func setValue(_ value: Any, forKey key: String) -> PBXBuildConfigurationBuilder {
        buildSettings[key] = value
        return self
    }

    @discardableResult
    func setBaseConfiguration(_ filename: String) -> PBXBuildConfigurationBuilder {
        baseConfiguration = PBXFileReference(path: filename)
        return self
    }

    func build() -> (XCBuildConfiguration, [PBXObject]) {
        let buildConfiguration = XCBuildConfiguration(name: name,
                                                      baseConfiguration: baseConfiguration,
                                                      buildSettings: buildSettings)
        let objects = [buildConfiguration, baseConfiguration].compactMap { $0 }
        return (buildConfiguration, objects)
    }
}
