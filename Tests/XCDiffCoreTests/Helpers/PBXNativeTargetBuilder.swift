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

struct PBXNativeTargetPrototype {
    let pbxtarget: PBXNativeTarget
    let objects: [PBXObject]
    let fileElements: [PBXFileElement] // need to be added to the main group
}

public enum BuildPhase: String {
    case sources = "Sources"
    case frameworks = "Frameworks"
    case resources = "Resources"
    case embedFrameworks = "EmbedFrameworks"
    case headers = "Headers"
}

final class PBXNativeTargetBuilder {
    private var pbxtarget: PBXNativeTarget
    private var objects: [PBXObject] = []
    private var fileElements: [PBXFileElement] = []

    init(name: String) {
        pbxtarget = PBXNativeTarget(name: name)
        objects.append(pbxtarget)
    }

    func build() -> PBXNativeTargetPrototype {
        return PBXNativeTargetPrototype(pbxtarget: pbxtarget,
                                        objects: objects,
                                        fileElements: fileElements)
    }

    @discardableResult
    func addBuildConfiguration(name: String, _ closure: ((PBXBuildConfigurationBuilder) -> Void)? = nil)
        -> PBXNativeTargetBuilder {
        let builder = PBXBuildConfigurationBuilder(name: name)
        closure?(builder)
        let (buildConfiguration, objects) = builder.build()
        let buildConfigurationList: XCConfigurationList
        if let targetConfigurationList = pbxtarget.buildConfigurationList {
            buildConfigurationList = targetConfigurationList
        } else {
            buildConfigurationList = XCConfigurationList()
            pbxtarget.buildConfigurationList = buildConfigurationList
            self.objects.append(buildConfigurationList)
        }

        buildConfigurationList.buildConfigurations.append(buildConfiguration)
        self.objects.append(contentsOf: objects)
        return self
    }

    @discardableResult
    func addBuildPhase(_ type: BuildPhase,
                       _ closure: (PBXBuildPhaseBuilder) -> Void) -> PBXNativeTargetBuilder {
        let builder = PBXBuildPhaseBuilder(type: type)
        closure(builder)
        let (buildPhase, buildPhaseObjects) = builder.build()
        pbxtarget.buildPhases.append(buildPhase)
        objects.append(contentsOf: buildPhaseObjects)
        let fileElements = buildPhase.files?.compactMap { $0.file } ?? []
        self.fileElements.append(contentsOf: fileElements)
        return self
    }

    @discardableResult
    func addHeaders(_ headers: [(path: String, accessLevel: PBXHeaderAccessLevel?)]) -> PBXNativeTargetBuilder {
        addBuildPhase(.headers) { buildPhaseBuilder in
            headers.forEach { header in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setPath(header.path)
                    if let accessLevel = header.accessLevel {
                        buildFileBuilder.setSettings(["ATTRIBUTES": accessLevel.rawValue])
                    }
                }
            }
        }
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

    @discardableResult
    func addResources(_ resources: [String]) -> PBXNativeTargetBuilder {
        addBuildPhase(.resources) { buildPhaseBuilder in
            resources.forEach { source in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setName(source)
                    buildFileBuilder.setPath(source)
                }
            }
        }
        return self
    }

    @discardableResult
    func addDependencies(_ dependencies: [DependencyData]) -> PBXNativeTargetBuilder {
        addBuildPhase(.frameworks) { buildPhaseBuilder in
            dependencies.forEach { dependency in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    if let name = dependency.name { buildFileBuilder.setName(name) }
                    if let path = dependency.path { buildFileBuilder.setPath(path) }
                    if let settings = dependency.settings { buildFileBuilder.setSettings(settings) }
                }
            }
        }
        return self
    }

    @discardableResult
    func addEmbeddedFrameworks(_ embeddedFrameworks: [EmbeddedFrameworksData]) -> PBXNativeTargetBuilder {
        addBuildPhase(.embedFrameworks) { buildPhaseBuilder in
            embeddedFrameworks.forEach { embeddedFramework in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setPath(embeddedFramework.path)
                    buildFileBuilder.setSettings(embeddedFramework.settings)
                }
            }
        }
        return self
    }
}

struct DependencyData {
    init(name: String? = nil,
         path: String? = nil,
         settings: [String: [String]]? = nil) {
        self.name = name
        self.path = path
        self.settings = settings
    }

    let name: String?
    let path: String?
    let settings: [String: [String]]?
}

struct EmbeddedFrameworksData {
    let path: String
    let settings: [String: [String]]
}
