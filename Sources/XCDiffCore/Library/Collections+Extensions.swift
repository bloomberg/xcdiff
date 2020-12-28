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

extension Set where Element: Hashable, Element: Comparable {
    func subtractingAndSorted(_ second: Set<Element>?) -> [Element] {
        return subtracting(second ?? []).sorted()
    }

    func intersectionSorted(_ second: Set<Element>?) -> [Element] {
        return intersection(second ?? []).sorted()
    }
}

extension Array where Element: Hashable, Element: Comparable {
    func subtractingAndSorted(_ second: [Element]?) -> [Element] {
        return Set(self).subtractingAndSorted(second?.toSet())
    }

    func commonSorted(_ second: [Element]?) -> [Element] {
        return Set(self).intersectionSorted(second?.toSet())
    }

    func toSet() -> Set<Element> {
        return Set(self)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
