# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "json", "-v"]
```

# Expected exit code
1

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
      "ProjectUITests\/Screenshots\/empty.png"
    ],
    "onlyInSecond" : [
      "NewFramework.framework",
      "NewFramework\/Info.plist",
      "NewFramework\/NewFramework.h",
      "ProjectFramework\/Header4.h",
      "ProjectTests\/Responses\/ListResponse.json",
      "ProjectUITests\/MetricsTests.swift",
      "README.md"
    ],
    "tag" : "file_references"
  },
  {
    "context" : [
      "NATIVE targets"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "NewFramework"
    ],
    "tag" : "targets"
  },
  {
    "context" : [
      "AGGREGATE targets"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "NewAggregate"
    ],
    "tag" : "targets"
  },
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "headers"
  },
  {
    "context" : [
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [
      {
        "context" : "\/ProjectFramework\/Header1.h attributes",
        "first" : "Public",
        "second" : "nil (Project)"
      },
      {
        "context" : "\/ProjectFramework\/Header2.h attributes",
        "first" : "Private",
        "second" : "nil (Project)"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "\/ProjectFramework\/Header4.h"
    ],
    "tag" : "headers"
  },
  {
    "context" : [
      "\"ProjectTests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "headers"
  },
  {
    "context" : [
      "\"ProjectUITests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "headers"
  },
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [
      {
        "context" : "\/Project\/Group A\/ObjcClass.m compiler flags",
        "second" : "-ObjC"
      }
    ],
    "onlyInFirst" : [
      "\/Project\/Group B\/AnotherObjcClass.m"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "sources"
  },
  {
    "context" : [
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "sources"
  },
  {
    "context" : [
      "\"ProjectTests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "\/ProjectTests\/BarTests.swift"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "sources"
  },
  {
    "context" : [
      "\"ProjectUITests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "\/ProjectUITests\/LoginTests.swift"
    ],
    "onlyInSecond" : [
      "\/ProjectUITests\/MetricsTests.swift"
    ],
    "tag" : "sources"
  },
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "\/Project\/Group B\/AViewController.xib",
      "\/Project\/Resources\/time.png"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "resources"
  },
  {
    "context" : [
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "resources"
  },
  {
    "context" : [
      "\"ProjectTests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "\/ProjectTests\/Responses\/ListResponse.json"
    ],
    "tag" : "resources"
  },
  {
    "context" : [
      "\"ProjectUITests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "\/ProjectUITests\/Screenshots\/empty.png"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "resources"
  }
]

```
