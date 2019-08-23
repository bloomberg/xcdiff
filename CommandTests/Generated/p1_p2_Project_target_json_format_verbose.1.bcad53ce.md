# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-f", "json", "-v"]
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
      "Project\/Project.xcconfig",
      "Project\/Target.xcconfig",
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
      "\"Project\" target"
    ],
    "differentValues" : [
      {
        "context" : "\/Project\/Group A\/ObjcClass.m compiler flags",
        "first" : "nil",
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
      "Root project"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "CUSTOM_NEW"
    ],
    "tag" : "configurations"
  },
  {
    "context" : [
      "Root project",
      "\"Debug\" configuration",
      "Base configuration"
    ],
    "differentValues" : [
      {
        "context" : "Path to .xcconfig",
        "first" : "nil",
        "second" : "\/Project\/Project.xcconfig"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "Root project",
      "\"Debug\" configuration",
      "Values"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "CUSTOM_SETTGING_1"
    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "Root project",
      "\"Release\" configuration",
      "Base configuration"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "Root project",
      "\"Release\" configuration",
      "Values"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "CUSTOM_SETTGING_1"
    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"Debug\" configuration",
      "Base configuration"
    ],
    "differentValues" : [
      {
        "context" : "Path to .xcconfig",
        "first" : "nil",
        "second" : "\/Project\/Target.xcconfig"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"Debug\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "CUSTOM_SETTING_COMMON",
        "first" : "VALUE_1",
        "second" : "VALUE_2"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"Release\" configuration",
      "Base configuration"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"Release\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "CUSTOM_SETTING_COMMON",
        "first" : "VALUE_1",
        "second" : "VALUE_2"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  }
]

```
