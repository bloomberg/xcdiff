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
import PathKit
@testable import XCDiffCore
import XcodeProj
import XCTest

final class PBXProjBuilder {
    private var pbxproj: PBXProj
    private var pbxproject: PBXProject
    private let projectDirPath: Path

    init(name: String = "Project",
         configurationListBuilder: XCConfigurationListBuilder = XCConfigurationListBuilder(),
         projectDirPath: Path = Path("/projectDirPath")) {
        self.projectDirPath = projectDirPath
        (pbxproj, pbxproject) = PBXProjBuilder.createNewProject(name: name,
                                                                configurationListBuilder: configurationListBuilder,
                                                                projectDirPath: projectDirPath.string)
    }

    @discardableResult
    func addBuildConfiguration(name: String, _ closure: ((PBXBuildConfigurationBuilder) -> Void)? = nil)
        -> PBXProjBuilder {
        let builder = PBXBuildConfigurationBuilder(name: name)
        closure?(builder)
        let (buildConfiguration, objects) = builder.build()
        pbxproject.buildConfigurationList.buildConfigurations.append(buildConfiguration)
        objects.forEach { pbxproj.add(object: $0) }
        return self
    }

    @discardableResult
    func addTarget(name: String = "Target",
                   productType: PBXProductType? = nil,
                   _ closure: ((PBXNativeTargetBuilder) -> Void)? = nil) -> PBXProjBuilder {
        let builder = PBXNativeTargetBuilder(name: name, productType: productType)
        closure?(builder)
        let nativeTargetPrototype = builder.build()
        pbxproject.targets.append(nativeTargetPrototype.pbxtarget)
        nativeTargetPrototype.objects.forEach { pbxproj.add(object: $0) }
        let group = PBXGroup(children: nativeTargetPrototype.fileElements, sourceTree: .group, name: name)
        pbxproj.add(object: group)
        nativeTargetPrototype.fileElements.forEach { $0.parent = group }
        group.parent = pbxproject.mainGroup
        pbxproject.mainGroup.children.append(group)
        return self
    }

    @discardableResult
    func addTargets(names: [String], _ closure: ((PBXNativeTargetBuilder) -> Void)? = nil) -> PBXProjBuilder {
        names.forEach { addTarget(name: $0, closure) }
        return self
    }

    @discardableResult
    func addAggregateTarget(name: String = "Target",
                            _ closure: ((PBXAggregateTargetBuilder) -> Void)? = nil) -> PBXProjBuilder {
        let builder = PBXAggregateTargetBuilder(name: name)
        closure?(builder)
        let (target, targetObjects) = builder.build()
        pbxproject.targets.append(target)
        targetObjects.forEach { pbxproj.add(object: $0) }
        return self
    }

    @discardableResult
    func addAggregateTargets(names: [String],
                             _ closure: ((PBXAggregateTargetBuilder) -> Void)? = nil) -> PBXProjBuilder {
        names.forEach { addAggregateTarget(name: $0, closure) }
        return self
    }

    @discardableResult
    func addFileReferences(_ paths: [String]) -> PBXProjBuilder {
        paths.forEach { addFileReference($0) }
        return self
    }

    @discardableResult
    func addFileReference(_ path: String) -> PBXProjBuilder {
        pbxproj.add(object: PBXFileReference(path: path))
        return self
    }

    func build() -> PBXProj {
        return pbxproj
    }

    // MARK: - Private

    private static func createNewProject(name: String,
                                         configurationListBuilder: XCConfigurationListBuilder,
                                         projectDirPath: String) -> (PBXProj, PBXProject) {
        let (configurationList, configurationListObjects) = configurationListBuilder.build()
        let mainGroup = createMainGroup()
        let project = PBXProject(name: name,
                                 buildConfigurationList: configurationList,
                                 compatibilityVersion: Xcode.Default.compatibilityVersion,
                                 mainGroup: mainGroup,
                                 projectDirPath: projectDirPath)
        let objects = configurationListObjects + [mainGroup, project]
        let proj = PBXProj(rootObject: project,
                           objects: objects)

        return (proj, project)
    }

    private static func createMainGroup() -> PBXGroup {
        return PBXGroup()
    }
}

extension PBXProjBuilder {
    func projectDescriptor() -> ProjectDescriptor {
        let workspace = XCWorkspace(data: XCWorkspaceData(children: []))
        let pbxproj = build()
        let xcodeproj = XcodeProj(workspace: workspace, pbxproj: pbxproj)
        return ProjectDescriptor(path: projectDirPath, xcodeProj: xcodeproj)
    }
}

extension XCTestCase {
    func project(name: String = "Project") -> PBXProjBuilder {
        return PBXProjBuilder(name: name)
    }
}
