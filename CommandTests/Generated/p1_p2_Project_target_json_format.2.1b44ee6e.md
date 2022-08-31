# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-f", "json"]
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
    "tag" : "build_phases"
  },
  {
    "context" : [
      "\"Project\" target",
      "Embed Frameworks"
    ],
    "differentValues" : [
      {
        "context" : "ProjectFramework.framework",
        "first" : "attributes = [\"CodeSignOnCopy\", \"RemoveHeadersOnCopy\"]",
        "second" : "attributes = []"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary.framework",
      "NewFramework.framework"
    ],
    "tag" : "copy_files"
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
        "context" : "Project\/Group A\/ObjcClass.m compiler flags",
        "first" : "nil",
        "second" : "-ObjC"
      }
    ],
    "onlyInFirst" : [
      "Project\/Group B\/AnotherObjcClass.m"
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
      "Project\/Group B\/AViewController.xib",
      "Project\/Resources\/time.png"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "resources"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"Second script\" build phase"
    ],
    "differentValues" : [
      {
        "context" : "shellScript",
        "first" : "echo \"First Hello, world!\"\n",
        "second" : "echo \"second script\"\n"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "run_scripts"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"ShellScript\" build phase"
    ],
    "differentValues" : [
      {
        "context" : "shellScript",
        "first" : "echo \"Hello, World!\"\n",
        "second" : "echo \"Hello, world?\"\n"
      },
      {
        "context" : "showEnvVarsInLog",
        "first" : "true",
        "second" : "false"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "run_scripts"
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
        "second" : "Project\/Project.xcconfig"
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
      "CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL"
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
      "CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL"
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
        "second" : "Project\/Target.xcconfig"
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
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES"
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
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES"
    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "Root project"
    ],
    "description" : "Output format: (<path>, <name>, <source_tree>)",
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "(AViewController.xib, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)",
      "(AnotherObjcClass.h, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)",
      "(AnotherObjcClass.m, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)",
      "(BarTests.swift, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)",
      "(LoginTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)",
      "(empty.png, nil, <group>) → (Screenshots, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)",
      "(libMismatchingLibrary.a, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)",
      "(time.png, nil, <group>) → (Resources, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)"
    ],
    "onlyInSecond" : [
      "(Header4.h, nil, <group>) → (ProjectFramework, nil, <group>) → (nil, nil, <group>)",
      "(Info.plist, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)",
      "(ListResponse.json, nil, <group>) → (Responses, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)",
      "(MetricsTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)",
      "(MismatchingLibrary-Info.plist, nil, <group>) → (MismatchingLibrary, nil, <group>) → (nil, nil, <group>)",
      "(MismatchingLibrary.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)",
      "(NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)",
      "(NewFramework.h, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)",
      "(Project.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)",
      "(README.md, nil, <group>) → (nil, nil, <group>)",
      "(Target.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)"
    ],
    "tag" : "source_trees"
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
      "(target=MismatchingLibrary)",
      "(target=NewFramework)"
    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [
      {
        "context" : "ARKit.framework attributes",
        "first" : "required",
        "second" : "optional"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary.framework",
      "NewFramework.framework"
    ],
    "tag" : "linked_dependencies"
  },
  {
    "context" : [
      "Root project"
    ],
    "differentValues" : [
      {
        "context" : "LastSwiftUpdateCheck",
        "first" : "1110",
        "second" : "1030"
      },
      {
        "context" : "LastUpgradeCheck",
        "first" : "1020",
        "second" : "1030"
      },
      {
        "context" : "ORGANIZATIONNAME",
        "first" : "Bloomberg LP",
        "second" : "Another Organization"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "attributes"
  },
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [
      {
        "context" : "LastSwiftMigration",
        "first" : "1140",
        "second" : "1020"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "attributes"
  },
  {
    "context" : [

    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "swift_packages"
  }
]

```
