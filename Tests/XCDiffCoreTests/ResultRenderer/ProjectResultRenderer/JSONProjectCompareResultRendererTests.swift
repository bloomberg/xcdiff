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

final class JSONProjectCompareResultRendererTests: XCTestCase {
    private var outputBuffer: StringOutputBuffer!
    private let fixtures = Fixtures()

    override func setUp() {
        super.setUp()

        outputBuffer = StringOutputBuffer()
    }

    func testRender_whenVerboseTrue() throws {
        // Given
        let subject = JSONProjectCompareResultRenderer(output: outputBuffer.any(), verbose: true)
        let result = fixtures.projectCompareResult.sample1()

        // When
        try subject.render(result)

        // Then
        XCTAssertEqual(content, expectedContent)
    }

    // The result is the same as for Verbose=true case, JSON format always contains all the details
    func testRender_whenVerboseFalse() throws {
        // Given
        let subject = JSONProjectCompareResultRenderer(output: outputBuffer.any(), verbose: false)
        let result = fixtures.projectCompareResult.sample1()

        // When
        try subject.render(result)

        // Then
        XCTAssertEqual(content, expectedContent)
    }

    // MARK: - Private

    private let expectedContent = """
    [
      {
        "context" : [
          "Context1",
          "Context2"
        ],
        "differentValues" : [
          {
            "context" : "DV1",
            "first" : "DV1_V1",
            "second" : "nil"
          },
          {
            "context" : "DV2",
            "first" : "nil",
            "second" : "DV2_V2"
          },
          {
            "context" : "DV3",
            "first" : "DV3_V1",
            "second" : "DV3_V2"
          },
          {
            "context" : "DV4",
            "first" : "DV4_V1",
            "second" : "DV4_V2"
          }
        ],
        "onlyInFirst" : [
          "OIF1",
          "OIF2"
        ],
        "onlyInSecond" : [
          "OIS1",
          "OIS2",
          "OIS3"
        ],
        "tag" : "Tag1"
      },
      {
        "context" : [
          "Context1",
          "Context2"
        ],
        "differentValues" : [
          {
            "context" : "DV1",
            "first" : "DV1_V1",
            "second" : "nil"
          },
          {
            "context" : "DV2",
            "first" : "nil",
            "second" : "DV2_V2"
          },
          {
            "context" : "DV3",
            "first" : "DV3_V1",
            "second" : "DV3_V2"
          },
          {
            "context" : "DV4",
            "first" : "DV4_V1",
            "second" : "DV4_V2"
          }
        ],
        "onlyInFirst" : [
          "OIF1",
          "OIF2"
        ],
        "onlyInSecond" : [
          "OIS1",
          "OIS2",
          "OIS3"
        ],
        "tag" : "Tag2"
      }
    ]
    """

    private var content: String {
        return outputBuffer.flush()
    }
}
