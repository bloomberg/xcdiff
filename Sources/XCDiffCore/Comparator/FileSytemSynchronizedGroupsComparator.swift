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

final class FileSytemSynchronizedGroupsComparator: Comparator {
    let tag = "filesystem_synchronized_groups"
    private let targetsHelper = TargetsHelper()

    func compare(
        _ first: ProjectDescriptor,
        _ second: ProjectDescriptor,
        parameters: ComparatorParameters
    ) throws -> [CompareResult] {
        try targetsHelper.commonTargets(first, second, parameters: parameters)
            .map { firstTarget, secondTarget in
                try compare(
                    firstTarget,
                    secondTarget,
                    firstSourceRoot: first.sourceRoot,
                    secondSourceRoot: second.sourceRoot
                )
            }
    }

    // MARK: - Private

    private func compare(
        _ first: PBXTarget,
        _ second: PBXTarget,
        firstSourceRoot: Path,
        secondSourceRoot: Path
    ) throws -> CompareResult {
        result(
            context: ["\"\(first.name)\" target"],
            first: try targetsHelper.fileSystemSynchronizedGroups(from: first, sourceRoot: firstSourceRoot),
            second: try targetsHelper.fileSystemSynchronizedGroups(from: second, sourceRoot: secondSourceRoot)
        )
    }
}
