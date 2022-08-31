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
    var attributes: [String: String]
    var targetReferenceAttributes: [String: String]
}

enum DstSubfolderSpec {
    case frameworks
    case plugins
    case resources
}

struct CopyFilesBuildPhase {
    static let frameworks = CopyFilesBuildPhase(dstSubfolderSpec: .frameworks)
    static let plugins = CopyFilesBuildPhase(dstSubfolderSpec: .plugins)

    var name: String?
    var dstSubfolderSpec: DstSubfolderSpec?
    var dstPath: String?
}

struct RunScriptBuildPhase {
    var name: String?
    var inputPaths: [String]
    var outputPaths: [String]
    var shellPath: String
    var shellScript: String?
    var showEnvVarsInLog: Bool
    var alwaysOutOfDate: Bool
    var dependencyFile: String?

    init(name: String? = nil,
         inputPaths: [String] = [],
         outputPaths: [String] = [],
         shellPath: String = "/bin/sh",
         shellScript: String? = nil,
         showEnvVarsInLog: Bool = false,
         alwaysOutOfDate: Bool = false,
         dependencyFile: String? = nil) {
        self.name = name
        self.inputPaths = inputPaths
        self.outputPaths = outputPaths
        self.shellPath = shellPath
        self.shellScript = shellScript
        self.showEnvVarsInLog = showEnvVarsInLog
        self.alwaysOutOfDate = alwaysOutOfDate
        self.dependencyFile = dependencyFile
    }
}

enum BuildPhase {
    case sources
    case frameworks
    case resources
    case shellScripts(RunScriptBuildPhase = RunScriptBuildPhase())
    case copyFiles(CopyFilesBuildPhase)
    case headers
}

final class PBXNativeTargetBuilder {
    private var pbxtarget: PBXNativeTarget
    private var objects: [PBXObject] = []
    private var fileElements: [PBXFileElement] = []
    private var dependencies: [PBXTargetDependency] = []
    private var attributes: [String: String] = [:]
    private var targetReferenceAttributes: [String: String] = [:]

    init(name: String, productType: PBXProductType?) {
        pbxtarget = PBXNativeTarget(name: name, productType: productType)
        objects.append(pbxtarget)
    }

    func build() -> PBXNativeTargetPrototype {
        return PBXNativeTargetPrototype(
            pbxtarget: pbxtarget,
            objects: objects,
            fileElements: fileElements,
            attributes: attributes,
            targetReferenceAttributes: targetReferenceAttributes
        )
    }

    @discardableResult
    func addBuildConfigurationList() -> PBXNativeTargetBuilder {
        if pbxtarget.buildConfigurationList != nil {
            return self
        }
        let buildConfigurationList = XCConfigurationList()
        pbxtarget.buildConfigurationList = buildConfigurationList
        objects.append(buildConfigurationList)
        return self
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
                    if let accessLevel = header.accessLevel?.pbxAttributes() {
                        buildFileBuilder.setSettings(["ATTRIBUTES": accessLevel])
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
            resources.forEach { resource in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setName(resource)
                    buildFileBuilder.setPath(resource)
                }
            }
        }
        return self
    }

    @discardableResult
    func addResources(_ resources: [(name: String, sourceTree: SourceTree)]) -> PBXNativeTargetBuilder {
        addBuildPhase(.resources) { buildPhaseBuilder in
            resources.forEach { resource in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setName(resource.name)
                    buildFileBuilder.setPath(resource.name)
                    buildFileBuilder.setSourceTree(resource.sourceTree.pbxSourceTree)
                }
            }
        }
        return self
    }

    @discardableResult
    func addLinkedDependencies(_ linkedDependencies: [LinkedDependenciesData]) -> PBXNativeTargetBuilder {
        addBuildPhase(.frameworks) { buildPhaseBuilder in
            linkedDependencies.forEach { linkedDependency in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    if let name = linkedDependency.name { buildFileBuilder.setName(name) }
                    if let path = linkedDependency.path { buildFileBuilder.setPath(path) }
                    if let settings = linkedDependency.settings { buildFileBuilder.setSettings(settings) }
                    if let packageProduct = linkedDependency.packageProduct {
                        buildFileBuilder.setPackageProduct(packageProduct)
                    }
                }
            }
        }
        return self
    }

    @discardableResult
    func addEmbeddedFrameworks(_ embeddedFrameworks: [EmbeddedFrameworksData]) -> PBXNativeTargetBuilder {
        addBuildPhase(.copyFiles(.frameworks)) { buildPhaseBuilder in
            embeddedFrameworks.forEach { embeddedFramework in
                buildPhaseBuilder.addBuildFile { buildFileBuilder in
                    buildFileBuilder.setPath(embeddedFramework.path)
                    if let settings = embeddedFramework.settings { buildFileBuilder.setSettings(settings) }
                }
            }
        }
        return self
    }

    @discardableResult
    func addAttribute(name: String, value: String) -> PBXNativeTargetBuilder {
        attributes[name] = value
        return self
    }

    @discardableResult
    func addAttribute(name: String, referenceTarget: String) -> PBXNativeTargetBuilder {
        targetReferenceAttributes[name] = referenceTarget
        return self
    }
}

struct LinkedDependenciesData {
    var name: String?
    var path: String?
    var packageProduct: SwiftPackageProductDependencyData?
    var settings: [String: [String]]?
}

struct EmbeddedFrameworksData {
    let path: String
    let settings: [String: [String]]?
}

enum SourceTree {
    case buildProducts
    case group

    fileprivate var pbxSourceTree: PBXSourceTree {
        switch self {
        case .buildProducts: return .buildProductsDir
        case .group: return .group
        }
    }
}
