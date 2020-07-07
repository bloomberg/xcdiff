//
// Copyright 2020 Bloomberg Finance L.P.
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
import XcodeProj

final class DependenciesComparator: Comparator {
    let tag = "dependencies"

    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return try targetsHelper
            .commonTargets(first, second, parameters: parameters)
            .flatMap { try compare($0, $1,
                                   firstSourceRoot: first.sourceRoot,
                                   secondSourceRoot: second.sourceRoot) }
    }

    // MARK: - Private

    private func compare(_ first: PBXTarget, _ second: PBXTarget,
                         firstSourceRoot: Path,
                         secondSourceRoot: Path) throws -> [CompareResult] {
        return results(context: ["\"\(first.name)\" target"],
                       first: stringDependencyDescriptors(from: first, sourceRoot: firstSourceRoot),
                       second: stringDependencyDescriptors(from: second, sourceRoot: secondSourceRoot))
    }

    private func stringDependencyDescriptors(from target: PBXTarget, sourceRoot: Path) -> Set<String> {
        return target.dependencies
            .map(dependencyDescriptor)
            .map { $0.description(sourceRoot: sourceRoot) }
            .toSet()
    }

    private func dependencyDescriptor(from dependency: PBXTargetDependency) -> DependencyDescriptor {
        let name = dependency.name
        let productName = dependency.product?.productName
        if let target = dependency.target {
            return .init(name: name, productName: productName, context: .target(target.name))
        }
        if let proxy = dependency.targetProxy {
            return .init(name: name, productName: productName, context: .proxy(proxy.proxyType, proxy.containerPortal))
        }
        return .init(name: name, productName: productName, context: .none)
    }
}

private struct DependencyDescriptor {
    enum Context {
        case none
        case target(String)
        case proxy(PBXContainerItemProxy.ProxyType?, PBXContainerItemProxy.ContainerPortal)

        func description(sourceRoot: Path) -> String {
            switch self {
            case .none:
                return "context=none"
            case let .target(name):
                return "target=\(name)"
            case let .proxy(proxyType, containerPortal):
                var result = [String]()
                if let proxyTypeString = string(from: proxyType) {
                    result.append(proxyTypeString)
                }
                result.append(string(from: containerPortal, sourceRoot: sourceRoot))
                return result.joined(separator: ", ")
            }
        }

        private func string(from proxyType: PBXContainerItemProxy.ProxyType?) -> String? {
            guard let proxyType = proxyType else {
                return nil
            }
            switch proxyType {
            case .nativeTarget:
                return "proxy_type=native_target"
            case .reference:
                return "proxy_type=reference"
            case .other:
                return "proxy_type=other"
            }
        }

        private func string(from containerPortal: PBXContainerItemProxy.ContainerPortal,
                            sourceRoot: Path) -> String {
            switch containerPortal {
            case let .fileReference(fileReference):
                let pathHelper = PathHelper()
                let path = try? pathHelper.fullPath(from: fileReference, sourceRoot: sourceRoot)
                return "proxy_file_reference(path=\(path ?? "nil"))"
            case let .project(project):
                return "proxy_project=\(project.name)"
            case .unknownObject:
                return "proxy_unknown_object"
            }
        }
    }

    let name: String?
    let productName: String?
    let context: Context

    func description(sourceRoot: Path) -> String {
        var result = [String]()

        // name
        if case let .target(target) = context {
            if let name = name, name != target {
                result.append("name=\(name)")
            }
        } else if let name = name {
            result.append("name=\(name)")
        }

        // product name
        if let productName = productName {
            result.append("product_name=\(productName.description)")
        }

        // context
        result.append(context.description(sourceRoot: sourceRoot))
        return "(\(result.joined(separator: ", ")))"
    }
}
