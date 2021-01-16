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
    private var platformFilter: String?
    private var settings: [String: Any]?
    private var packageProduct: SwiftPackageProductDependencyData?

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
    func setPackageProduct(_ packageProduct: SwiftPackageProductDependencyData) -> PBXBuildFileBuilder {
        self.packageProduct = packageProduct
        return self
    }

    @discardableResult
    func setSettings(_ settings: [String: [String]]) -> PBXBuildFileBuilder {
        self.settings = settings
        return self
    }

    @discardableResult
    func setSettings(_ settings: [String: String]) -> PBXBuildFileBuilder {
        self.settings = settings
        return self
    }

    @discardableResult
    func setPlatformFilter(_ platformFilter: String?) -> PBXBuildFileBuilder {
        self.platformFilter = platformFilter
        return self
    }

    func build() -> (PBXBuildFile, [PBXObject]) {
        let fileReference = PBXFileReference(sourceTree: sourceTree,
                                             name: name,
                                             path: path)
        let buildFile = PBXBuildFile(file: fileReference, settings: settings)
        buildFile.platformFilter = platformFilter
        var objects: [PBXObject?] = [buildFile, fileReference]

        if let packageProduct = packageProduct {
            let packageReference = packageProduct.package.map {
                XCRemoteSwiftPackageReference(
                    repositoryURL: $0.url,
                    versionRequirement: $0.version
                )
            }
            let product = XCSwiftPackageProductDependency(
                productName: packageProduct.productName,
                package: packageReference
            )
            buildFile.product = product
            objects.append(product)
            objects.append(packageReference)
        }

        return (buildFile, objects.compactMap { $0 })
    }
}
