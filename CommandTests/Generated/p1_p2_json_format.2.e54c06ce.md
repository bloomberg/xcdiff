# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "json"]
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
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [
      "CopyFiles"
    ],
    "onlyInSecond" : [
      "Headers",
      "Resources"
    ],
    "tag" : "build_phases"
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
      "\"ProjectFramework\" target"
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
      "\"ProjectTests\" target"
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
      "\"ProjectUITests\" target"
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
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "copy_files"
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
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "copy_files"
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
    "tag" : "copy_files"
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
    "tag" : "copy_files"
  },
  {
    "context" : [
      "NATIVE targets"
    ],
    "differentValues" : [
      {
        "context" : "MismatchingLibrary product type",
        "first" : "com.apple.product-type.library.static",
        "second" : "com.apple.product-type.framework"
      }
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
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary\/MismatchingLibrary.h"
    ],
    "tag" : "headers"
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
        "context" : "ProjectFramework\/Header1.h attributes",
        "first" : "Public",
        "second" : "nil (Project)"
      },
      {
        "context" : "ProjectFramework\/Header2.h attributes",
        "first" : "Private",
        "second" : "nil (Project)"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "ProjectFramework\/Header4.h"
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
      "\"MismatchingLibrary\" target"
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
      "ProjectTests\/BarTests.swift"
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
      "ProjectUITests\/LoginTests.swift"
    ],
    "onlyInSecond" : [
      "ProjectUITests\/MetricsTests.swift"
    ],
    "tag" : "sources"
  },
  {
    "context" : [
      "\"MismatchingLibrary\" target"
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
      "ProjectTests\/Responses\/ListResponse.json"
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
      "ProjectUITests\/Screenshots\/empty.png"
    ],
    "onlyInSecond" : [

    ],
    "tag" : "resources"
  },
  {
    "context" : [
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

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
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "run_scripts"
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
    "tag" : "run_scripts"
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
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
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
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
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
    "tag" : "dependencies"
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
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "linked_dependencies"
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
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "linked_dependencies"
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
    "tag" : "linked_dependencies"
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
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "LastSwiftMigration = 1110"
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
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "attributes"
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
    "tag" : "attributes"
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
      "TestTargetID = Project"
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
