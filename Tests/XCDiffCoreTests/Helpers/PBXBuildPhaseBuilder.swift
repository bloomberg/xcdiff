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
    private var name: String?
    private var buildFiles: [PBXBuildFile] = []
    private var objects: [PBXObject] = []
    private var inputFileListPaths: [String]?
    private var outputFileListPaths: [String]?
    private var runOnlyForDeploymentPostprocessing: Bool
    private let type: BuildPhase

    init(type: BuildPhase) {
        self.type = type
        runOnlyForDeploymentPostprocessing = false
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

    @discardableResult
    func setName(_ name: String) -> PBXBuildPhaseBuilder {
        self.name = name
        return self
    }

    @discardableResult
    func setInputFileListPaths(_ paths: [String]) -> PBXBuildPhaseBuilder {
        inputFileListPaths = paths
        return self
    }

    @discardableResult
    func setOutputFileListPaths(_ paths: [String]) -> PBXBuildPhaseBuilder {
        outputFileListPaths = paths
        return self
    }

    @discardableResult
    func setRunOnlyForDeploymentPostprocessing(_ value: Bool) -> PBXBuildPhaseBuilder {
        runOnlyForDeploymentPostprocessing = value
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
        case let .shellScripts(runScriptBuildPhase):
            buildPhase = PBXShellScriptBuildPhase(name: runScriptBuildPhase.name,
                                                  inputPaths: runScriptBuildPhase.inputPaths,
                                                  outputPaths: runScriptBuildPhase.outputPaths,
                                                  shellPath: runScriptBuildPhase.shellPath,
                                                  shellScript: runScriptBuildPhase.shellScript,
                                                  showEnvVarsInLog: runScriptBuildPhase.showEnvVarsInLog,
                                                  alwaysOutOfDate: runScriptBuildPhase.alwaysOutOfDate,
                                                  dependencyFile: runScriptBuildPhase.dependencyFile)
        case let .copyFiles(copyBuildPhase):
            buildPhase = PBXCopyFilesBuildPhase(dstPath: copyBuildPhase.dstPath,
                                                dstSubfolderSpec: .from(copyBuildPhase.dstSubfolderSpec),
                                                name: copyBuildPhase.name,
                                                files: buildFiles)
        }
        buildPhase.inputFileListPaths = inputFileListPaths
        buildPhase.outputFileListPaths = outputFileListPaths
        buildPhase.runOnlyForDeploymentPostprocessing = runOnlyForDeploymentPostprocessing
        return (buildPhase, objects + [buildPhase])
    }
}

private extension PBXCopyFilesBuildPhase.SubFolder {
    static func from(_ spec: DstSubfolderSpec?) -> PBXCopyFilesBuildPhase.SubFolder? {
        return spec.map {
            switch $0 {
            case .frameworks:
                return .frameworks
            case .plugins:
                return .plugins
            case .resources:
                return .resources
            }
        }
    }
}
