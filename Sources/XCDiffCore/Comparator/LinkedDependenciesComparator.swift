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

final class LinkedDependenciesComparator: Comparator {
    private typealias DependencyDescriptorPair = (first: LinkedDependencyDescriptor,
                                                  second: LinkedDependencyDescriptor)
    private typealias EmbeddedFrameworksDescriptorPair = (first: EmbeddedFrameworksDescriptor,
                                                          second: EmbeddedFrameworksDescriptor)
    private let targetsHelper = TargetsHelper()

    let tag = "linked_dependencies"

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let commonTargets = try targetsHelper.commonTargets(first, second, parameters: parameters)
        let results = try commonTargets.map { commonTarget in
            try createLinkedDependenciesResults(commonTarget: commonTarget)
        }

        return results
    }

    private func createLinkedDependenciesResults(commonTarget: TargetPair) throws -> CompareResult {
        let firstDependencies = try targetsHelper.linkedDependencies(from: commonTarget.first)
        let secondDependencies = try targetsHelper.linkedDependencies(from: commonTarget.second)

        let firstPaths = Set(firstDependencies.compactMap { dependencyKey(dependency: $0) })
        let secondPaths = Set(secondDependencies.compactMap { dependencyKey(dependency: $0) })

        let descriptorPairs = commonDependencyDescriptorPairs(first: firstDependencies,
                                                              second: secondDependencies)

        let attributesDifferences = self.attributesDifferences(in: descriptorPairs)
        let packagesDifferences = packageDifferences(in: descriptorPairs)

        return result(context: ["\"\(commonTarget.first.name)\" target"],
                      first: firstPaths,
                      second: secondPaths,
                      differentValues: attributesDifferences + packagesDifferences)
    }

    private func dependencyKey(dependency: LinkedDependencyDescriptor) -> String? {
        if let key = dependency.name ?? dependency.path { return key }
        return nil
    }

    private func commonDependencyDescriptorPairs(first: [LinkedDependencyDescriptor],
                                                 second: [LinkedDependencyDescriptor]) -> [DependencyDescriptorPair] {
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

    private func packageDifferences(in dependencyDescriptorPairs: [DependencyDescriptorPair])
        -> [CompareResult.DifferentValues] {
        return dependencyDescriptorPairs
            .filter { $0.package != $1.package }
            .compactMap { first, second -> CompareResult.DifferentValues? in
                if let key = dependencyKey(dependency: first) {
                    return .init(context: "\(key) package reference",
                                 first: first.package?.difference(from: second.package),
                                 second: second.package?.difference(from: first.package))
                }
                return nil
            }
    }

    private func dependencyPathMap(from dependencyDescriptors: [LinkedDependencyDescriptor])
        -> [String: LinkedDependencyDescriptor] {
        return Dictionary(dependencyDescriptors.compactMap {
            if let key = dependencyKey(dependency: $0) { return (key, $0) }
            return nil
        },
        uniquingKeysWith: { first, _ in first })
    }
}
