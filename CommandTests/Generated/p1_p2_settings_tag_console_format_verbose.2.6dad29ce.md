# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ SETTINGS > Root project > "Debug" configuration > Base configuration

⚠️  Value mismatch (1):

  • Path to .xcconfig
    ◦ nil
    ◦ Project/Project.xcconfig


❌ SETTINGS > Root project > "Debug" configuration > Values

⚠️  Only in second (1):

  • CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL


✅ SETTINGS > Root project > "Release" configuration > Base configuration
❌ SETTINGS > Root project > "Release" configuration > Values

⚠️  Only in second (1):

  • CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL


✅ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values

⚠️  Only in first (1):

  • OTHER_LDFLAGS = -ObjC


⚠️  Only in second (13):

  • CLANG_ENABLE_MODULES = YES
  • CURRENT_PROJECT_VERSION = 1
  • DEFINES_MODULE = YES
  • DYLIB_COMPATIBILITY_VERSION = 1
  • DYLIB_CURRENT_VERSION = 1
  • DYLIB_INSTALL_NAME_BASE = @rpath
  • INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist
  • INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks
  • LD_RUNPATH_SEARCH_PATHS = ["$(inherited)", "@executable_path/Frameworks", "@loader_path/Frameworks"]
  • PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary
  • SWIFT_OPTIMIZATION_LEVEL = -Onone
  • VERSIONING_SYSTEM = apple-generic
  • VERSION_INFO_PREFIX = 


⚠️  Value mismatch (1):

  • PRODUCT_NAME
    ◦ $(TARGET_NAME)
    ◦ $(TARGET_NAME:c99extidentifier)


✅ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values

⚠️  Only in first (1):

  • OTHER_LDFLAGS = -ObjC


⚠️  Only in second (12):

  • CLANG_ENABLE_MODULES = YES
  • CURRENT_PROJECT_VERSION = 1
  • DEFINES_MODULE = YES
  • DYLIB_COMPATIBILITY_VERSION = 1
  • DYLIB_CURRENT_VERSION = 1
  • DYLIB_INSTALL_NAME_BASE = @rpath
  • INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist
  • INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks
  • LD_RUNPATH_SEARCH_PATHS = ["$(inherited)", "@executable_path/Frameworks", "@loader_path/Frameworks"]
  • PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary
  • VERSIONING_SYSTEM = apple-generic
  • VERSION_INFO_PREFIX = 


⚠️  Value mismatch (1):

  • PRODUCT_NAME
    ◦ $(TARGET_NAME)
    ◦ $(TARGET_NAME:c99extidentifier)


❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration

⚠️  Value mismatch (1):

  • Path to .xcconfig
    ◦ nil
    ◦ Project/Target.xcconfig


❌ SETTINGS > "Project" target > "Debug" configuration > Values

⚠️  Only in second (1):

  • ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES


⚠️  Value mismatch (1):

  • CUSTOM_SETTING_COMMON
    ◦ VALUE_1
    ◦ VALUE_2


✅ SETTINGS > "Project" target > "Release" configuration > Base configuration
❌ SETTINGS > "Project" target > "Release" configuration > Values

⚠️  Only in second (1):

  • ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES


⚠️  Value mismatch (1):

  • CUSTOM_SETTING_COMMON
    ◦ VALUE_1
    ◦ VALUE_2


✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration
❌ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values

⚠️  Value mismatch (1):

  • PRODUCT_BUNDLE_IDENTIFIER
    ◦ com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework
    ◦ com.bloomberg.xcdiff.Project.ProjectFramework


✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration
❌ SETTINGS > "ProjectFramework" target > "Release" configuration > Values

⚠️  Value mismatch (1):

  • PRODUCT_BUNDLE_IDENTIFIER
    ◦ com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework
    ◦ com.bloomberg.xcdiff.Project.ProjectFramework


✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration
❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values

⚠️  Only in first (1):

  • PROVISIONING_PROFILE = 


⚠️  Only in second (1):

  • TEST_TARGET_NAME = Project


✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values

⚠️  Only in first (1):

  • PROVISIONING_PROFILE = 


⚠️  Only in second (1):

  • TEST_TARGET_NAME = Project




```
