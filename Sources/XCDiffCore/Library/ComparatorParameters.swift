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

public struct ComparatorParameters: Equatable {
    public enum Option<T: Equatable>: Equatable {
        case all
        case some([T])
        case only(T)
        case none

        public func contains(_ value: T) -> Bool {
            return values()?.contains(value) ?? true
        }

        public func values() -> [T]? {
            switch self {
            case .all:
                return nil
            case let .some(options):
                return options
            case let .only(option):
                return [option]
            case .none:
                return []
            }
        }
    }

    public let targets: Option<String>
    public let configurations: Option<String>

    public init(targets: Option<String>,
                configurations: Option<String>) {
        self.targets = targets
        self.configurations = configurations
    }
}

extension Array where Array.Element == String {
    func filter(by option: ComparatorParameters.Option<String>) -> [String] {
        return filter { option.contains($0) }
    }
}

extension Set where Set.Element == String {
    func filter(by option: ComparatorParameters.Option<String>) -> Set<String> {
        return filter { option.contains($0) }
    }
}
