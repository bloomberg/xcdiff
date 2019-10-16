# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
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
      "\"MismatchingLibrary\" target",
      "\"Debug\" configuration",
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
      "\"MismatchingLibrary\" target",
      "\"Debug\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "PRODUCT_NAME",
        "first" : "$(TARGET_NAME)",
        "second" : "$(TARGET_NAME:c99extidentifier)"
      }
    ],
    "onlyInFirst" : [
      "OTHER_LDFLAGS"
    ],
    "onlyInSecond" : [
      "CLANG_ENABLE_MODULES",
      "CURRENT_PROJECT_VERSION",
      "DEFINES_MODULE",
      "DYLIB_COMPATIBILITY_VERSION",
      "DYLIB_CURRENT_VERSION",
      "DYLIB_INSTALL_NAME_BASE",
      "INFOPLIST_FILE",
      "INSTALL_PATH",
      "LD_RUNPATH_SEARCH_PATHS",
      "PRODUCT_BUNDLE_IDENTIFIER",
      "SWIFT_OPTIMIZATION_LEVEL",
      "VERSIONING_SYSTEM",
      "VERSION_INFO_PREFIX"
    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"MismatchingLibrary\" target",
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
      "\"MismatchingLibrary\" target",
      "\"Release\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "PRODUCT_NAME",
        "first" : "$(TARGET_NAME)",
        "second" : "$(TARGET_NAME:c99extidentifier)"
      }
    ],
    "onlyInFirst" : [
      "OTHER_LDFLAGS"
    ],
    "onlyInSecond" : [
      "CLANG_ENABLE_MODULES",
      "CURRENT_PROJECT_VERSION",
      "DEFINES_MODULE",
      "DYLIB_COMPATIBILITY_VERSION",
      "DYLIB_CURRENT_VERSION",
      "DYLIB_INSTALL_NAME_BASE",
      "INFOPLIST_FILE",
      "INSTALL_PATH",
      "LD_RUNPATH_SEARCH_PATHS",
      "PRODUCT_BUNDLE_IDENTIFIER",
      "VERSIONING_SYSTEM",
      "VERSION_INFO_PREFIX"
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
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"
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
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES"
    ],
    "tag" : "settings"
  },
  {
    "context" : [
      "\"ProjectFramework\" target",
      "\"Debug\" configuration",
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
      "\"ProjectFramework\" target",
      "\"Debug\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "PRODUCT_BUNDLE_IDENTIFIER",
        "first" : "com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework",
        "second" : "com.bloomberg.xcdiff.Project.ProjectFramework"
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
      "\"ProjectFramework\" target",
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
      "\"ProjectFramework\" target",
      "\"Release\" configuration",
      "Values"
    ],
    "differentValues" : [
      {
        "context" : "PRODUCT_BUNDLE_IDENTIFIER",
        "first" : "com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework",
        "second" : "com.bloomberg.xcdiff.Project.ProjectFramework"
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
      "\"ProjectTests\" target",
      "\"Debug\" configuration",
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
      "\"ProjectTests\" target",
      "\"Debug\" configuration",
      "Values"
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
      "\"ProjectTests\" target",
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
      "\"ProjectTests\" target",
      "\"Release\" configuration",
      "Values"
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
      "\"ProjectUITests\" target",
      "\"Debug\" configuration",
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
      "\"ProjectUITests\" target",
      "\"Debug\" configuration",
      "Values"
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
      "\"ProjectUITests\" target",
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
      "\"ProjectUITests\" target",
      "\"Release\" configuration",
      "Values"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "settings"
  }
]

```
