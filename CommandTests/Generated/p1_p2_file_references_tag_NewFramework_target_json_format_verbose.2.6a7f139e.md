# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "file_references", "-t", "NewFramework", "-f", "json", "-v"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [

    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "Project\/Group B\/AViewController.xib",
      "Project\/Group B\/AnotherObjcClass.h",
      "Project\/Group B\/AnotherObjcClass.m",
      "Project\/Resources\/time.png",
      "ProjectTests\/BarTests.swift",
      "ProjectUITests\/LoginTests.swift",
      "ProjectUITests\/Screenshots\/empty.png",
      "libMismatchingLibrary.a"
    ],
    "onlyInSecond" : [
      "MismatchingLibrary.framework",
      "MismatchingLibrary\/MismatchingLibrary-Info.plist",
      "NewFramework.framework",
      "NewFramework\/Info.plist",
      "NewFramework\/NewFramework.h",
      "Project\/Project.xcconfig",
      "Project\/Target.xcconfig",
      "ProjectFramework\/Header4.h",
      "ProjectTests\/Responses\/ListResponse.json",
      "ProjectUITests\/MetricsTests.swift",
      "README.md"
    ],
    "tag" : "file_references"
  }
]

```
