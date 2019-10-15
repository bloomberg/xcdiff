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

final class SourcesComparator: Comparator {
    private typealias SourcePair = (first: SourceDescriptor, second: SourceDescriptor)

    let tag = "sources"
    private let targetsHelper = TargetsHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)
        return try commonTargets
            .map { firstTarget, secondTarget -> CompareResult in
                let firstSources = try targetsHelper.sources(from: firstTarget, sourceRoot: first.sourceRoot)
                let secondSources = try targetsHelper.sources(from: secondTarget, sourceRoot: second.sourceRoot)

                let firstPaths = Set(firstSources.map { $0.path })
                let secondPaths = Set(secondSources.map { $0.path })

                let commonSources = commonSourcesPair(first: firstSources, second: secondSources)
                let difference = compilerFlagDifferences(in: commonSources)

                return result(context: ["\"\(firstTarget.name)\" target"],
                              first: firstPaths,
                              second: secondPaths,
                              differentValues: difference)
            }
    }

    /// Returns common sources as a source pair
    private func commonSourcesPair(first: [SourceDescriptor], second: [SourceDescriptor]) -> [SourcePair] {
        let firstSourcesMapping = sourcePathMapping(from: first)
        let secondSourcesMapping = sourcePathMapping(from: second)

        let firstPaths = Set(firstSourcesMapping.keys)
        let secondPaths = Set(secondSourcesMapping.keys)

        let commonSources: [SourcePair] = firstPaths.intersection(secondPaths).map {
            (firstSourcesMapping[$0]!, secondSourcesMapping[$0]!)
        }

        return commonSources
    }

    /// Returns compiler flag differences between source pairs
    private func compilerFlagDifferences(in sourcePairs: [SourcePair]) -> [CompareResult.DifferentValues] {
        return sourcePairs.compactMap { sourcePair in
            let (first, second) = sourcePair
            if first.flags != second.flags {
                return CompareResult.DifferentValues(context: "\(first.path) compiler flags",
                                                     first: first.flags,
                                                     second: second.flags)
            }
            return nil
        }
    }

    /// Returns a dictionary that maps sources by their path `[path: SourceDescriptor]`
    private func sourcePathMapping(from sources: [SourceDescriptor]) -> [String: SourceDescriptor] {
        return Dictionary(sources.map { ($0.path, $0) }, uniquingKeysWith: { first, _ in first })
    }
}
