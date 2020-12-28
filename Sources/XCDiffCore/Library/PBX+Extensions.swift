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
import XcodeProj

extension PBXCopyFilesBuildPhase.SubFolder: CustomStringConvertible {
    public var description: String {
        switch self {
        case .absolutePath: return "absolutePath"
        case .productsDirectory: return "productsDirectory"
        case .wrapper: return "wrapper"
        case .executables: return "executables"
        case .resources: return "resources"
        case .javaResources: return "javaResources"
        case .frameworks: return "frameworks"
        case .sharedFrameworks: return "sharedFrameworks"
        case .sharedSupport: return "sharedSupport"
        case .plugins: return "plugins"
        case .other: return "other"
        }
    }
}

extension PBXTarget {
    func copyFilesBuildPhases() -> [PBXCopyFilesBuildPhase] {
        return buildPhases
            .filter { $0.buildPhase == .copyFiles }
            .compactMap { $0 as? PBXCopyFilesBuildPhase }
    }
}

extension XCRemoteSwiftPackageReference.VersionRequirement: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .upToNextMajorVersion(version):
            return ".upToNextMajorVersion(\(version))"
        case let .upToNextMinorVersion(version):
            return ".upToNextMinorVersion(\(version))"
        case let .range(from: fromVersion, to: toVersion):
            return ".range(\(fromVersion) ... \(toVersion))"
        case let .exact(version):
            return ".exact(\(version))"
        case let .branch(branch):
            return ".branch(\(branch))"
        case let .revision(revision):
            return ".revision(\(revision))"
        }
    }
}
