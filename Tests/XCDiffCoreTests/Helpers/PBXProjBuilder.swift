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

// swiftlint:disable force_cast force_try
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

        let stringAttributes: [String: Any] = nativeTargetPrototype.attributes
        let targetReferenceAttributes: [String: Any] = nativeTargetPrototype
            .targetReferenceAttributes
            .compactMapValues { targetName in
                if let referencedTarget = pbxproject.targets.first(where: { $0.name == targetName }) {
                    return referencedTarget
                }
                return nil
            }
        let allAttributes = stringAttributes.merging(targetReferenceAttributes, uniquingKeysWith: { $1 })
        if !allAttributes.isEmpty {
            pbxproject.targetAttributes[nativeTargetPrototype.pbxtarget] = allAttributes
        }

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

    @discardableResult
    func addAttribute(name: String, value: String) -> PBXProjBuilder {
        pbxproj.rootObject?.attributes[name] = value
        return self
    }

    @discardableResult
    func addRemoteSwiftPackage(
        url: String,
        version: XCRemoteSwiftPackageReference.VersionRequirement? = nil
    ) -> PBXProjBuilder {
        let package = XCRemoteSwiftPackageReference(repositoryURL: url, versionRequirement: version)
        pbxproj.add(object: package)
        pbxproj.rootObject?.packages.append(package)
        return self
    }

    @discardableResult
    func make(target targetName: String, dependOn dependencyTargetNames: [String]) -> PBXProjBuilder {
        let target = pbxproj.targets(named: targetName).first as! PBXNativeTarget
        dependencyTargetNames.forEach {
            let dependencyTarget = pbxproj.targets(named: $0).first!
            _ = try! target.addDependency(target: dependencyTarget)
        }
        return self
    }

    @discardableResult
    func make(target targetName: String, dependOn dependencies: [DependencyType]) -> PBXProjBuilder {
        dependencies.forEach {
            make(target: targetName, dependOn: $0)
        }
        return self
    }

    @discardableResult
    func make(target targetName: String, dependOn dependency: DependencyType) -> PBXProjBuilder {
        switch dependency {
        case let .target(value):
            return make(target: targetName, dependOn: value)
        case let .targetProxy(value):
            return make(target: targetName, dependOn: value)
        case let .swiftPackage(value):
            return make(target: targetName, dependOn: value)
        }
    }

    func build() -> PBXProj {
        return pbxproj
    }

    // MARK: - Private

    private func make(target targetName: String, dependOn dependency: TargetDependencyData) -> PBXProjBuilder {
        let target = pbxproj.targets(named: targetName).first as! PBXNativeTarget
        var dependencyTarget: PBXTarget?
        if let targetName = dependency.targetName {
            dependencyTarget = pbxproj.targets(named: targetName).first!
        }
        let targetDependency = PBXTargetDependency(name: dependency.name, target: dependencyTarget)
        pbxproj.add(object: targetDependency)
        target.dependencies.append(targetDependency)
        return self
    }

    private func make(target targetName: String, dependOn dependency: TargetProxyDependencyData) -> PBXProjBuilder {
        let target = pbxproj.targets(named: targetName).first as! PBXNativeTarget
        let containerPortal: PBXContainerItemProxy.ContainerPortal
        switch dependency.containerPortal {
        case let .project(descriptor):
            containerPortal = .project(try! descriptor.pbxproj.rootProject()!)
        case let .fileReference(path):
            let fileReference = PBXFileReference(sourceTree: .absolute, path: path)
            pbxproj.add(object: fileReference)
            containerPortal = .fileReference(fileReference)
        case .unknown:
            containerPortal = .unknownObject(nil)
        }
        let targetProxy = PBXContainerItemProxy(containerPortal: containerPortal, proxyType: dependency.proxyType)
        pbxproj.add(object: targetProxy)
        let targetDependency = PBXTargetDependency(name: dependency.name,
                                                   targetProxy: targetProxy)
        pbxproj.add(object: targetDependency)
        target.dependencies.append(targetDependency)
        return self
    }

    private func make(target targetName: String,
                      dependOn dependency: SwiftPackageProductDependencyData) -> PBXProjBuilder {
        let target = pbxproj.targets(named: targetName).first as! PBXNativeTarget
        let swiftPackageDependency = XCSwiftPackageProductDependency(productName: dependency.productName)
        if let package = dependency.package {
            swiftPackageDependency.package = pbxproject.packages.first(where: { $0.repositoryURL == package.url })
        }
        pbxproj.add(object: swiftPackageDependency)
        let targetDependency = PBXTargetDependency(name: dependency.name,
                                                   product: swiftPackageDependency)
        pbxproj.add(object: targetDependency)
        target.dependencies.append(targetDependency)
        return self
    }

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

// swiftlint:enable force_cast force_try

enum DependencyType {
    case target(TargetDependencyData)
    case targetProxy(TargetProxyDependencyData)
    case swiftPackage(SwiftPackageProductDependencyData)
}

struct TargetDependencyData {
    let name: String?
    let targetName: String?
}

struct TargetProxyDependencyData {
    let name: String?
    let proxyType: PBXContainerItemProxy.ProxyType?
    let containerPortal: ContainerPortal
}

struct SwiftPackageProductDependencyData {
    var name: String?
    var productName: String
    var package: RemoteSwiftPackageData?
}

struct RemoteSwiftPackageData {
    var url: String
    var version: XCRemoteSwiftPackageReference.VersionRequirement?
}

enum ContainerPortal {
    case project(ProjectDescriptor)
    case fileReference(String)
    case unknown
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
