//
// Copyright 2025 Bloomberg Finance L.P.
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

protocol TargetsPlistHelperProtocol {
    func infoPlist(target: PBXTarget, sourceRoot: Path) throws -> PlistDescriptor
    func entitlementsPlist(target: PBXTarget, sourceRoot: Path) throws -> PlistDescriptor
}

final class TargetsPlistHelper: TargetsPlistHelperProtocol {
    func infoPlist(target: PBXTarget, sourceRoot: Path) throws -> PlistDescriptor {
        let plistType: PlistDescriptor.PlistType = .info
        let plistPath = plistPath(target: target, sourceRoot: sourceRoot, plistKey: plistType.buildSettingsKey)
        let plistData = try plistPath.read()

        return try .init(target: target.name, path: plistPath, plistData: plistData, type: plistType)
    }

    func entitlementsPlist(target: PBXTarget, sourceRoot: Path) throws -> PlistDescriptor {
        let plistType: PlistDescriptor.PlistType = .entitlements
        let plistPath = plistPath(target: target, sourceRoot: sourceRoot, plistKey: plistType.buildSettingsKey)
        let plistData = try plistPath.read()

        return try .init(target: target.name, path: plistPath, plistData: plistData, type: plistType)
    }
}

private extension TargetsPlistHelper {
    func plistPath(target: PBXTarget, sourceRoot: Path, plistKey: String) -> Path {
        let buildConfig = target.buildConfigurationList?.buildConfigurations.first
        let plistPathString = buildConfig?.buildSettings[plistKey] as? String ?? ""

        return sourceRoot + Path(plistPathString)
    }
}
