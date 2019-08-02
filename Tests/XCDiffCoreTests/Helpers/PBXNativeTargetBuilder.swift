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

final class PBXNativeTargetBuilder {
    private var pbxtarget: PBXNativeTarget
    private var objects: [PBXObject] = []

    init(name: String) {
        pbxtarget = PBXNativeTarget(name: name)
        objects.append(pbxtarget)
    }

    func build() -> (PBXNativeTarget, [PBXObject]) {
        return (pbxtarget, objects)
    }

    @discardableResult
    func addBuildPhase(_ type: BuildPhase, _ closure: (PBXBuildPhaseBuilder) -> Void) -> PBXNativeTargetBuilder {
        let builder = PBXBuildPhaseBuilder()
        closure(builder)
        let (buildPhase, buildPhaseObjects) = builder.build(type)
        pbxtarget.buildPhases.append(buildPhase)
        objects.append(contentsOf: buildPhaseObjects)
        return self
    }

    @discardableResult
    func addSources(_ sources: [String]) -> PBXNativeTargetBuilder {
        addBuildPhase(.sources) { buildPhaseBuilder in
            sources.forEach { source in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setName(source)
                    buildFileBuilder.setPath(source)
                }
            }
        }
        return self
    }

    @discardableResult
    func addSources(_ sources: [(name: String, flags: String)]) -> PBXNativeTargetBuilder {
        addBuildPhase(.sources) { buildPhaseBuilder in
            sources.forEach { source in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setName(source.name)
                    buildFileBuilder.setPath(source.name)
                    buildFileBuilder.setSettings(["COMPILER_FLAGS": source.flags])
                }
            }
        }
        return self
    }
}
