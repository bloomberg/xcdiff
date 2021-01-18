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
@testable import XCDiffCore
import XcodeProj
import XCTest

final class PBXExtensionsTests: XCTestCase {
    func testPBXCopyFilesBuildPhaseSubFolderDescription() {
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.absolutePath.description, "absolutePath")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.productsDirectory.description, "productsDirectory")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.wrapper.description, "wrapper")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.executables.description, "executables")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.resources.description, "resources")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.javaResources.description, "javaResources")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.frameworks.description, "frameworks")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.sharedFrameworks.description, "sharedFrameworks")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.sharedSupport.description, "sharedSupport")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.plugins.description, "plugins")
        XCTAssertEqual(PBXCopyFilesBuildPhase.SubFolder.other.description, "other")
    }

    func testVersionRequirementStrings() {
        // Given
        let subjects: [XCRemoteSwiftPackageReference.VersionRequirement] = [
            .branch("main"),
            .exact("1.2.0"),
            .range(from: "0.1.0", to: "0.2.0"),
            .revision("abcdef"),
            .upToNextMajorVersion("1.2.0"),
            .upToNextMinorVersion("0.2.1"),
        ]

        // When
        let results = subjects.map(\.description)

        // Then
        XCTAssertEqual(results, [
            ".branch(main)",
            ".exact(1.2.0)",
            ".range(0.1.0 ... 0.2.0)",
            ".revision(abcdef)",
            ".upToNextMajorVersion(1.2.0)",
            ".upToNextMinorVersion(0.2.1)",
        ])
    }
}
