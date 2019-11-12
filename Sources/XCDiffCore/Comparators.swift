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

public struct Comparators {
    public struct Tags {
        public static let fileReferences = "file_references"
        public static let targets = "targets"
        public static let headers = "headers"
        public static let sources = "sources"
        public static let resources = "resources"
        public static let configurations = "configurations"
        public static let settings = "settings"
        public static let resolvedSettings = "resolved_settings"
        public static let sourceTrees = "source_trees"
        public static let dependencies = "dependencies"
    }
    public static let fileReferences: () -> Comparator = { FileReferencesComparator() }
    public static let targets: () -> Comparator = { TargetsComparator() }
    public static let headers: () -> Comparator = { HeadersComparator() }
    public static let sources: () -> Comparator = { SourcesComparator() }
    public static let resources: () -> Comparator = { ResourcesComparator() }
    public static let configurations: () -> Comparator = { ConfigurationsComparator() }
    public static let settings: () -> Comparator = { SettingsComparator() }
    public static let resolvedSettings: () -> Comparator = { ResolvedSettingsComparator(system: DefaultSystem()) }
    public static let sourceTrees: () -> Comparator = { SourceTreesComparator() }
    public static let dependencies: () -> Comparator = { DependenciesComparator() }
    public static var allAvailableComparators: [() -> Comparator] {
        return [
            fileReferences,
            targets,
            headers,
            sources,
            resources,
            configurations,
            settings,
            resolvedSettings,
            sourceTrees,
            dependencies,
        ]
    }
    public static var defaultComparators: [() -> Comparator] {
        return [
            fileReferences,
            targets,
            headers,
            sources,
            resources,
            configurations,
            settings,
            sourceTrees,
            dependencies,
        ]
    }
}
