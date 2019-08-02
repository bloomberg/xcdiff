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

import XcodeProj

final class PBXBuildFileBuilder {
    private var sourceTree: PBXSourceTree = .absolute
    private var path: String?
    private var name: String?
    private var settings: [String: String]?

    @discardableResult
    func setSourceTree(_ sourceTree: PBXSourceTree) -> PBXBuildFileBuilder {
        self.sourceTree = sourceTree
        return self
    }

    @discardableResult
    func setPath(_ path: String) -> PBXBuildFileBuilder {
        self.path = path
        return self
    }

    @discardableResult
    func setName(_ name: String) -> PBXBuildFileBuilder {
        self.name = name
        return self
    }

    @discardableResult
    func setSettings(_ settings: [String: String]) -> PBXBuildFileBuilder {
        self.settings = settings
        return self
    }

    func build() -> (PBXBuildFile, [PBXObject]) {
        let fileReference = PBXFileReference(sourceTree: sourceTree,
                                             name: name,
                                             path: path)
        let buildFile = PBXBuildFile(file: fileReference, settings: settings)
        let objects: [PBXObject] = [buildFile, fileReference]
        return (buildFile, objects)
    }
}
