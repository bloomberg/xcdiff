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

@testable import XCDiffCore

final class ComparatorMock: Comparator {
    typealias CompareClosure = (ProjectDescriptor, ProjectDescriptor, ComparatorParameters) -> [CompareResult]
    var tag: ComparatorTag

    private let compareClosure: CompareClosure

    init(tag: ComparatorTag, compare: @escaping CompareClosure = { _, _, _ in [] }) {
        self.tag = tag
        compareClosure = compare
    }

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        return compareClosure(first, second, parameters)
    }
}
