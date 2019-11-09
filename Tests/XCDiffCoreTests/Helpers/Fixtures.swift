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

final class Fixtures {
    let projectCompareResult = ProjectCompareResultFixtures()
    let project = ProjectFixtures()
}

final class ProjectCompareResultFixtures {
    let compareResult = CompareResultFixtures()

    func create(_ results: [CompareResult]) -> ProjectCompareResult {
        let first = PBXProjBuilder(name: "Project1", projectDirPath: Path("/path/to/first.xcodeproj"))
            .projectDescriptor()
        let second = PBXProjBuilder(name: "Project2", projectDirPath: Path("/path/to/second.xcodeproj"))
            .projectDescriptor()
        return ProjectCompareResult(first: first,
                                    second: second,
                                    results: results)
    }

    func sample1() -> ProjectCompareResult {
        let firstResult = compareResult.singleWithMultipleDifferences(tag: "Tag1")
        let secondResult = compareResult.singleWithMultipleDifferences(tag: "Tag2")
        return create([firstResult, secondResult])
    }
}

final class CompareResultFixtures {
    func singleWithMultipleDifferences(tag: ComparatorTag) -> CompareResult {
        return CompareResult(tag: tag,
                             context: ["Context1", "Context2"],
                             description: nil,
                             onlyInFirst: ["OIF1", "OIF2"],
                             onlyInSecond: ["OIS1", "OIS2", "OIS3"],
                             differentValues: [
                                 CompareResult.DifferentValues(context: "DV1", first: "DV1_V1"),
                                 CompareResult.DifferentValues(context: "DV2", second: "DV2_V2"),
                                 CompareResult.DifferentValues(context: "DV3", first: "DV3_V1", second: "DV3_V2"),
                                 CompareResult.DifferentValues(context: "DV4", first: "DV4_V1", second: "DV4_V2"),
                             ])
    }
}

final class ProjectFixtures {
    func non_existing() -> Path {
        return path(to: "non_existing")
    }

    func ios_project_1() -> Path {
        return path(to: "ios_project_1")
    }

    // MARK: - Private

    private func path(to fixture: String) -> Path {
        let path = Path("\(fixture)/Project.xcodeproj")
        let absolutePath = rootPath() + path
        return absolutePath
    }

    private func rootPath() -> Path {
        let localFilePathComponents = URL(fileURLWithPath: #file).pathComponents
        guard let testsComponentIndex = localFilePathComponents.firstIndex(of: "XCDiffCoreTests") else {
            fatalError("Could not dtermine source root path")
        }
        let rootPathComponents = localFilePathComponents.prefix(upTo: testsComponentIndex)
        let projectRootPath = Path(String(rootPathComponents.joined(separator: "/").dropFirst())).parent()
        let fixturesRelativePath = Path("Fixtures")
        return projectRootPath + fixturesRelativePath
    }
}
