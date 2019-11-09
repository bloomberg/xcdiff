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

final class DependenciesComparator: Comparator {
    private typealias DependencyDescriptorPair = (first: DependencyDescriptor,
                                                  second: DependencyDescriptor)
    private typealias EmbeddedFrameworksDescriptorPair = (first: EmbeddedFrameworksDescriptor,
                                                          second: EmbeddedFrameworksDescriptor)
    private let targetsHelper = TargetsHelper()

    let tag = ComparatorTag.dependencies

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)
        let results = try commonTargets.flatMap { commonTarget in
            [try createLinkedDependenciesResults(commonTarget: commonTarget),
             try createEmbeddedFrameworksResults(commonTarget: commonTarget)]
        }

        return results
    }

    private func createLinkedDependenciesResults(commonTarget: TargetPair) throws -> CompareResult {
        let firstDependencies = try targetsHelper.dependencies(from: commonTarget.first)
        let secondDependencies = try targetsHelper.dependencies(from: commonTarget.second)

        let firstPaths = Set(firstDependencies.compactMap { dependencyKey(dependency: $0) })
        let secondPaths = Set(secondDependencies.compactMap { dependencyKey(dependency: $0) })

        let descriptorPairs = commonDependencyDescriptorPairs(first: firstDependencies,
                                                              second: secondDependencies)

        let differences = attributesDifferences(in: descriptorPairs)

        return result(context: ["\"\(commonTarget.first.name)\" target"] + ["Linked Dependencies"],
                      first: firstPaths,
                      second: secondPaths,
                      differentValues: differences)
    }

    private func createEmbeddedFrameworksResults(commonTarget: TargetPair) throws -> CompareResult {
        let firstEmbeddedFrameworks = try targetsHelper.embeddedFrameworks(from: commonTarget.first)
        let secondEmbeddedFrameworks = try targetsHelper.embeddedFrameworks(from: commonTarget.second)

        let firstEmbeddedPaths = Set(firstEmbeddedFrameworks.map { $0.path })
        let secondEmbeddedPaths = Set(secondEmbeddedFrameworks.map { $0.path })

        let commonEmbeddedFrameworkPairs = commonEmbeddedFrameworkDescriptorPairs(first: firstEmbeddedFrameworks,
                                                                                  second: secondEmbeddedFrameworks)

        let differences = attributesDifferences(in: commonEmbeddedFrameworkPairs)

        return result(context: ["\"\(commonTarget.first.name)\" target"] + ["Embedded Frameworks"],
                      first: firstEmbeddedPaths,
                      second: secondEmbeddedPaths,
                      differentValues: differences)
    }

    private func commonEmbeddedFrameworkDescriptorPairs(first: [EmbeddedFrameworksDescriptor],
                                                        second: [EmbeddedFrameworksDescriptor])
        -> [EmbeddedFrameworksDescriptorPair] {
        let firstEmbeddedFrameworkDescriptionMap = embeddedFrameworksPathMap(from: first)
        let secondEmbeddedFrameworkDescriptionMap = embeddedFrameworksPathMap(from: second)

        let firstPaths = Set(firstEmbeddedFrameworkDescriptionMap.keys)
        let secondPaths = Set(secondEmbeddedFrameworkDescriptionMap.keys)

        let commonSources = firstPaths
            .intersection(secondPaths)
            .map { (firstEmbeddedFrameworkDescriptionMap[$0]!, secondEmbeddedFrameworkDescriptionMap[$0]!) }
            .sorted { left, right in
                left.0.path < right.0.path
            }
        return commonSources
    }

    private func dependencyKey(dependency: DependencyDescriptor) -> String? {
        if let key = dependency.name ?? dependency.path { return key }
        return nil
    }

    private func commonDependencyDescriptorPairs(first: [DependencyDescriptor],
                                                 second: [DependencyDescriptor]) -> [DependencyDescriptorPair] {
        let firstDependencyDescriptorMap = dependencyPathMap(from: first)
        let secondDependencyDescriptorMap = dependencyPathMap(from: second)

        let firstPaths = Set(firstDependencyDescriptorMap.keys)
        let secondPaths = Set(secondDependencyDescriptorMap.keys)

        let commonSources = firstPaths
            .intersection(secondPaths)
            .map { (firstDependencyDescriptorMap[$0]!, secondDependencyDescriptorMap[$0]!) }
            .sorted { left, right in
                if let keyLeft = left.0.name ?? left.0.path,
                    let keyRight = right.0.name ?? right.0.path {
                    return keyLeft < keyRight
                }
                return false
            }
        return commonSources
    }

    private func attributesDifferences(in embeddedFrameworkDescriptorPairs: [EmbeddedFrameworksDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return embeddedFrameworkDescriptorPairs
            .filter { $0.codeSignOnCopy != $1.codeSignOnCopy }
            .map { first, second -> CompareResult.DifferentValues in
                .init(context: "\(first.path) Code Sign on Copy",
                      first: first.codeSignOnCopy.description,
                      second: second.codeSignOnCopy.description)
            }
    }

    private func attributesDifferences(in dependencyDescriptorPairs: [DependencyDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return dependencyDescriptorPairs
            .filter { $0.type != $1.type }
            .compactMap { first, second -> CompareResult.DifferentValues? in
                if let key = dependencyKey(dependency: first) {
                    return .init(context: "\(key) attributes",
                                 first: first.type.rawValue,
                                 second: second.type.rawValue)
                }
                return nil
            }
    }

    private func dependencyPathMap(from dependencyDescriptors: [DependencyDescriptor])
        -> [String: DependencyDescriptor] {
        return Dictionary(dependencyDescriptors.compactMap {
            if let key = dependencyKey(dependency: $0) { return (key, $0) }
            return nil
        },
                          uniquingKeysWith: { first, _ in first })
    }

    private func embeddedFrameworksPathMap(from embeddedFrameworkDescriptors: [EmbeddedFrameworksDescriptor])
        -> [String: EmbeddedFrameworksDescriptor] {
        return Dictionary(embeddedFrameworkDescriptors.map {
            ($0.path, $0)
        },
                          uniquingKeysWith: { first, _ in first })
    }
}
