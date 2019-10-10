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

final class PBXBuildPhaseBuilder {
    private var buildFiles: [PBXBuildFile] = []
    private var objects: [PBXObject] = []
    private let type: BuildPhase

    init(type: BuildPhase) {
        self.type = type
    }

    @discardableResult
    func addBuildFile(_ closure: (PBXBuildFileBuilder) -> Void) -> PBXBuildPhaseBuilder {
        let builder = PBXBuildFileBuilder()
        closure(builder)
        let (buildFile, buildFileObjects) = builder.build()
        buildFiles.append(buildFile)
        objects.append(contentsOf: buildFileObjects)
        return self
    }

    func build() -> (PBXBuildPhase, [PBXObject]) {
        let buildPhase: PBXBuildPhase
        switch type {
        case .resources:
            buildPhase = PBXResourcesBuildPhase(files: buildFiles)
        case .sources:
            buildPhase = PBXSourcesBuildPhase(files: buildFiles)
        case .headers:
            buildPhase = PBXHeadersBuildPhase(files: buildFiles)
        case .frameworks:
            buildPhase = PBXFrameworksBuildPhase(files: buildFiles)
        case .embedFrameworks:
            buildPhase = PBXCopyFilesBuildPhase(dstSubfolderSpec: .frameworks,
                                                files: buildFiles)
        }
        return (buildPhase, objects + [buildPhase])
    }
}
