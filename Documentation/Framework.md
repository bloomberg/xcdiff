# Framework

xcdiff can be used from a Swift macOS project in two ways:
- via `XCDiffCommand` as a subcommand of your own command line tool using Swift Package Manager command parser (`ArgumentParser`) from `SPMUtility` package.
- via [`XCDiffCore`](#XCDiffCore)

## XCDiffCore

This type of integration gives you full flexibility and allows to control all parameters, define custom comparators, and process output.

```swift
import XCDiffCore

func compare() {
    // prepare paths
    let path1 = Path("/path/to/project1.xcodeproj")
    let path2 = Path("/path/to/project2.xcodeproj")

    // create project comparator
    let mode = Mode(format: .console, verbose: true, differencesOnly: false)
    let projectComparator = ProjectComparatorFactory.create(comparators: .defaultComparators,
                                                            mode: mode)

    // prepare parameters
    let parameters = ComparatorParameters(targets: .all, configurations: .all)

    // compare and get the result
    let result = try projectComparator.compare(path1, path2, parameters: parameters)
}

```

### Creating a custom comparator

We implemented many commonly used comparators but it's very likely you will need to focus on the some part of the project we didn't think of. Fortunatelly writing new comparators is very easy. All you need to do is create a single class which implements the `XCDiffCore.Comparator` protocol.

The protocol requires a name string, by convention we use snake_case for the comparator names. The second requirement is the `compare` method.
**The method should respect parameters (`ComparatorParameters`) if they are applicable.**

```swift
import XCDiffCore

class MyComparator: XCDiffCore.Comparator {
    let tag = "my_comparator"

    func compare(_ first: ProjectDescriptor,
                 _ second: ProjectDescriptor,
                 parameters: ComparatorParameters) throws -> [CompareResult] {
        let firstObjectVersion = first.pbxproj.objectVersion
        let secondObjectVersion = second.pbxproj.objectVersion
        guard first.pbxproj.objectVersion == second.pbxproj.objectVersion else {
            return [.init(tag: tag,
                          context: ["Root project"],
                          differentValues: [
                            .init(context: "ObjectVersion",
                                  first: String(firstObjectVersion),
                                  second: String(secondObjectVersion))
                ])]
        }
        return []
    }
}
```

To use the new comparator you need to add it to the list of the comparator when you create the `ProjectComparator` object.

```swift

    // if you want to use just your comparator
    let comparators: [XCDiffCore.ComparatorType] = [.custom(MyComparator())]

    // or add it to the list of default comparators
    // let comparators: [XCDiffCore.ComparatorType]  = .defaultComparators + [.custom(MyComparator())]
    let projectComparator = ProjectComparatorFactory.create(comparators: comparators,
                                                            mode: mode)

```

**Remember, we :heart: contributions!**
If you think your new comparator would be beneficial for other projects, please send a PR. We would be more than happy to extend our default list of the comparators.