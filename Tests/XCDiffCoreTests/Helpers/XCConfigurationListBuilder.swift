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

final class XCConfigurationListBuilder {
    private var name: String?
    private var buildConfigurations: [XCBuildConfiguration] = []
    private var objects: [PBXObject] = []

    func setName(_ name: String) -> XCConfigurationListBuilder {
        self.name = name
        return self
    }

    func addBuildConfiguration(_ buildConfiguration: XCBuildConfiguration) -> XCConfigurationListBuilder {
        buildConfigurations.append(buildConfiguration)
        objects.append(buildConfiguration)
        objects.append(contentsOf: buildConfigurations.compactMap { $0.baseConfiguration })
        return self
    }

    func build() -> (XCConfigurationList, [PBXObject]) {
        let configurationList = XCConfigurationList(buildConfigurations: buildConfigurations,
                                                    defaultConfigurationName: name,
                                                    defaultConfigurationIsVisible: true)
        return (configurationList, objects + [configurationList])
    }
}
