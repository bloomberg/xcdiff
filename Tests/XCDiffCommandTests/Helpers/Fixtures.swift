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

final class Fixtures {
    let project = ProjectFixtures()
}

final class ProjectFixtures {
    enum Project: String, CaseIterable {
        // swiftlint:disable identifier_name
        case non_existing
        case ios_project_1
        case ios_project_2
        case ios_project_with_swift_packages_1
        case ios_project_with_swift_packages_2
        case ios_project_with_ui_tests_1
        case ios_project_with_ui_tests_2
        case ios_project_invalid_paths
        // swiftlint:enable identifier_name
    }

    func non_existing() -> Path {
        return path(to: .non_existing)
    }

    func ios_project_1() -> Path {
        return path(to: .ios_project_1)
    }

    func ios_project_2() -> Path {
        return path(to: .ios_project_2)
    }

    func ios_project_invalid_paths() -> Path {
        return path(to: .ios_project_invalid_paths)
    }

    func scenarios() -> [Path] {
        return Path.glob("\(rootPath().parent().string)/CommandTests/**/*.md")
    }

    func path(to project: Project) -> Path {
        let path = Path("\(project.rawValue)/Project.xcodeproj")
        let absolutePath = rootPath() + path
        return absolutePath
    }

    // MARK: - Private

    private func rootPath() -> Path {
        let localFilePathComponents = URL(fileURLWithPath: #file).pathComponents
        guard let testsComponentIndex = localFilePathComponents.firstIndex(of: "XCDiffCommandTests") else {
            fatalError("Could not determine source root path")
        }
        let rootPathComponents = localFilePathComponents.prefix(upTo: testsComponentIndex)
        let projectRootPath = Path(String(rootPathComponents.joined(separator: "/").dropFirst())).parent()
        let fixturesRelativePath = Path("Fixtures")
        return projectRootPath + fixturesRelativePath
    }
}
