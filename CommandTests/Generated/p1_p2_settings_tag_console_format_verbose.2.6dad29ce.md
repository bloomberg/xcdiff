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

  • CUSTOM_SETTGING_1


✅ SETTINGS > Root project > "Release" configuration > Base configuration
❌ SETTINGS > Root project > "Release" configuration > Values

⚠️  Only in second (1):

  • CUSTOM_SETTGING_1


✅ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values

⚠️  Only in first (1):

  • OTHER_LDFLAGS


⚠️  Only in second (13):

  • CLANG_ENABLE_MODULES
  • CURRENT_PROJECT_VERSION
  • DEFINES_MODULE
  • DYLIB_COMPATIBILITY_VERSION
  • DYLIB_CURRENT_VERSION
  • DYLIB_INSTALL_NAME_BASE
  • INFOPLIST_FILE
  • INSTALL_PATH
  • LD_RUNPATH_SEARCH_PATHS
  • PRODUCT_BUNDLE_IDENTIFIER
  • SWIFT_OPTIMIZATION_LEVEL
  • VERSIONING_SYSTEM
  • VERSION_INFO_PREFIX


⚠️  Value mismatch (1):

  • PRODUCT_NAME
    ◦ $(TARGET_NAME)
    ◦ $(TARGET_NAME:c99extidentifier)


✅ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values

⚠️  Only in first (1):

  • OTHER_LDFLAGS


⚠️  Only in second (12):

  • CLANG_ENABLE_MODULES
  • CURRENT_PROJECT_VERSION
  • DEFINES_MODULE
  • DYLIB_COMPATIBILITY_VERSION
  • DYLIB_CURRENT_VERSION
  • DYLIB_INSTALL_NAME_BASE
  • INFOPLIST_FILE
  • INSTALL_PATH
  • LD_RUNPATH_SEARCH_PATHS
  • PRODUCT_BUNDLE_IDENTIFIER
  • VERSIONING_SYSTEM
  • VERSION_INFO_PREFIX


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

  • ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES


⚠️  Value mismatch (1):

  • CUSTOM_SETTING_COMMON
    ◦ VALUE_1
    ◦ VALUE_2


✅ SETTINGS > "Project" target > "Release" configuration > Base configuration
❌ SETTINGS > "Project" target > "Release" configuration > Values

⚠️  Only in second (1):

  • ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES


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
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Values


```
