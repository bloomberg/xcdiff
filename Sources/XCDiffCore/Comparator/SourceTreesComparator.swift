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
import XcodeProj

final class SourceTreesComparator: Comparator {
    let tag = ComparatorTag.sourceTrees

    private let targetsHelper = TargetsHelper()
    private let pathHelper = PathHelper()

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters _: ComparatorParameters) throws -> [CompareResult] {
        let firstFileElements = try fileElements(from: first)
        let secondFileElements = try fileElements(from: second)
        let commonFileElements = firstFileElements.intersection(secondFileElements)
        let firstDictionary = firstFileElements
            .subtracting(commonFileElements)
            .map(pathFileElements)
            .toDictionary()
        let secondDictionary = secondFileElements
            .subtracting(commonFileElements)
            .map(pathFileElements)
            .toDictionary()

        let onlyInFirst = self.onlyInFirst(first: firstDictionary, second: secondDictionary)
        let onlyInSecond = self.onlyInSecond(first: firstDictionary, second: secondDictionary)
        let differentValues = self.differentValues(first: firstDictionary, second: secondDictionary)

        return results(context: ["Root project"],
                       description: "Output format: (<path>, <name>, <source_tree>)",
                       onlyInFirst: onlyInFirst,
                       onlyInSecond: onlyInSecond,
                       differentValues: differentValues)
    }

    // MARK: - Private

    private func onlyInFirst(first: [String?: [[FileElement]]],
                             second: [String?: [[FileElement]]]) -> [String] {
        return first
            .filter { $0.key == nil || !second.keys.contains($0.key) }
            .flatMap { $0.value }
            .sorted(by: sortByPath)
            .map(string)
    }

    private func onlyInSecond(first: [String?: [[FileElement]]],
                              second: [String?: [[FileElement]]]) -> [String] {
        return second
            .filter { $0.key == nil || !first.keys.contains($0.key) }
            .flatMap { $0.value }
            .sorted(by: sortByPath)
            .map(string)
    }

    private func differentValues(first: [String?: [[FileElement]]],
                                 second: [String?: [[FileElement]]]) -> [CompareResult.DifferentValues] {
        return first.keys
            .compactMap { $0 }
            .filter { second.keys.contains($0) }
            .filter { first[$0] != second[$0] }
            .map {
                let firstValue = first[$0]?
                    .map { string(from: $0) }
                    .joined(separator: ", ") ?? "nil"
                let secondValue = second[$0]?
                    .map { string(from: $0) }
                    .joined(separator: ", ") ?? "nil"
                return CompareResult.DifferentValues(context: $0,
                                                     first: firstValue,
                                                     second: secondValue)
            }
            .sorted { $0.context < $1.context }
    }

    private func fileElements(from projectDescriptor: ProjectDescriptor) throws -> Set<[FileElement]> {
        return try Set(projectDescriptor.pbxproj.fileReferences.map {
            try fileElements(from: $0, sourceRoot: projectDescriptor.sourceRoot)
        })
    }

    private func fileElements(from fileReference: PBXFileReference, sourceRoot: Path)
        throws -> [FileElement] {
        var result: [FileElement] = []
        var nextElement: PBXFileElement? = fileReference
        while let element = nextElement {
            let fullPath = try pathHelper.fullPath(from: element, sourceRoot: sourceRoot)
            result.append(element.toFileElement(fullPath: fullPath))
            nextElement = element.parent
        }
        return result
    }

    private func pathFileElements(from fileElements: [FileElement]) -> (String?, [[FileElement]]) {
        return (fileElements.first?.fullPath, [fileElements])
    }

    private func sortByPath(lha: [FileElement], rha: [FileElement]) -> Bool {
        return lha.first?.path ?? "" < rha.first?.path ?? ""
    }

    private func string(from fileElements: [FileElement]) -> String {
        return fileElements
            .map { $0.description }
            .joined(separator: " → ")
    }
}

private struct FileElement: Equatable, Hashable {
    let fullPath: String?
    let path: String?
    let name: String?
    let sourceTree: String?

    var description: String {
        return "(" +
            "\(path ?? "nil"), " +
            "\(name ?? "nil"), " +
            "\(sourceTree ?? "nil")" +
            ")"
    }
}

private extension PBXFileElement {
    func toFileElement(fullPath: String?) -> FileElement {
        return FileElement(fullPath: fullPath,
                           path: path,
                           name: name,
                           sourceTree: sourceTree?.description)
    }
}

private extension Array where Element == (String?, [[FileElement]]) {
    func toDictionary() -> [String?: [[FileElement]]] {
        return Dictionary(self, uniquingKeysWith: { lha, rha -> [[FileElement]] in
            lha + rha
        })
    }
}
