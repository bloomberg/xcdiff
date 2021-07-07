# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-f", "json", "-v"]
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
      "OTHER_LDFLAGS = -ObjC"
    ],
    "onlyInSecond" : [
      "CLANG_ENABLE_MODULES = YES",
      "CURRENT_PROJECT_VERSION = 1",
      "DEFINES_MODULE = YES",
      "DYLIB_COMPATIBILITY_VERSION = 1",
      "DYLIB_CURRENT_VERSION = 1",
      "DYLIB_INSTALL_NAME_BASE = @rpath",
      "INFOPLIST_FILE = MismatchingLibrary\/MismatchingLibrary-Info.plist",
      "INSTALL_PATH = $(LOCAL_LIBRARY_DIR)\/Frameworks",
      "LD_RUNPATH_SEARCH_PATHS = [\"$(inherited)\", \"@executable_path\/Frameworks\", \"@loader_path\/Frameworks\"]",
      "PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary",
      "SWIFT_OPTIMIZATION_LEVEL = -Onone",
      "VERSIONING_SYSTEM = apple-generic",
      "VERSION_INFO_PREFIX = "
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
      "OTHER_LDFLAGS = -ObjC"
    ],
    "onlyInSecond" : [
      "CLANG_ENABLE_MODULES = YES",
      "CURRENT_PROJECT_VERSION = 1",
      "DEFINES_MODULE = YES",
      "DYLIB_COMPATIBILITY_VERSION = 1",
      "DYLIB_CURRENT_VERSION = 1",
      "DYLIB_INSTALL_NAME_BASE = @rpath",
      "INFOPLIST_FILE = MismatchingLibrary\/MismatchingLibrary-Info.plist",
      "INSTALL_PATH = $(LOCAL_LIBRARY_DIR)\/Frameworks",
      "LD_RUNPATH_SEARCH_PATHS = [\"$(inherited)\", \"@executable_path\/Frameworks\", \"@loader_path\/Frameworks\"]",
      "PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary",
      "VERSIONING_SYSTEM = apple-generic",
      "VERSION_INFO_PREFIX = "
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
      "PROVISIONING_PROFILE = "
    ],
    "onlyInSecond" : [
      "TEST_TARGET_NAME = Project"
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
      "PROVISIONING_PROFILE = "
    ],
    "onlyInSecond" : [
      "TEST_TARGET_NAME = Project"
    ],
    "tag" : "settings"
  }
]

```
