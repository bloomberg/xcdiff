# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES

⚠️  Only in first (8):

  • Project/Group B/AViewController.xib
  • Project/Group B/AnotherObjcClass.h
  • Project/Group B/AnotherObjcClass.m
  • Project/Resources/time.png
  • ProjectTests/BarTests.swift
  • ProjectUITests/LoginTests.swift
  • ProjectUITests/Screenshots/empty.png
  • libMismatchingLibrary.a


⚠️  Only in second (11):

  • MismatchingLibrary.framework
  • MismatchingLibrary/MismatchingLibrary-Info.plist
  • NewFramework.framework
  • NewFramework/Info.plist
  • NewFramework/NewFramework.h
  • Project/Project.xcconfig
  • Project/Target.xcconfig
  • ProjectFramework/Header4.h
  • ProjectTests/Responses/ListResponse.json
  • ProjectUITests/MetricsTests.swift
  • README.md


❌ BUILD_PHASES > "MismatchingLibrary" target

⚠️  Only in first (1):

  • CopyFiles


⚠️  Only in second (2):

  • Headers
  • Resources


✅ BUILD_PHASES > "Project" target
✅ BUILD_PHASES > "ProjectFramework" target
✅ BUILD_PHASES > "ProjectTests" target
✅ BUILD_PHASES > "ProjectUITests" target
✅ COPY_FILES > "MismatchingLibrary" target
❌ COPY_FILES > "Project" target > Embed Frameworks

⚠️  Only in second (2):

  • MismatchingLibrary.framework
  • NewFramework.framework


⚠️  Value mismatch (1):

  • ProjectFramework.framework
    ◦ attributes = ["CodeSignOnCopy", "RemoveHeadersOnCopy"]
    ◦ attributes = []


✅ COPY_FILES > "ProjectFramework" target
✅ COPY_FILES > "ProjectTests" target
✅ COPY_FILES > "ProjectUITests" target
❌ TARGETS > NATIVE targets

⚠️  Only in second (1):

  • NewFramework


⚠️  Value mismatch (1):

  • MismatchingLibrary product type
    ◦ com.apple.product-type.library.static
    ◦ com.apple.product-type.framework


❌ TARGETS > AGGREGATE targets

⚠️  Only in second (1):

  • NewAggregate


❌ HEADERS > "MismatchingLibrary" target

⚠️  Only in second (1):

  • MismatchingLibrary/MismatchingLibrary.h


✅ HEADERS > "Project" target
❌ HEADERS > "ProjectFramework" target

⚠️  Only in second (1):

  • ProjectFramework/Header4.h


⚠️  Value mismatch (2):

  • ProjectFramework/Header1.h attributes
    ◦ Public
    ◦ nil (Project)

  • ProjectFramework/Header2.h attributes
    ◦ Private
    ◦ nil (Project)


✅ HEADERS > "ProjectTests" target
✅ HEADERS > "ProjectUITests" target
✅ SOURCES > "MismatchingLibrary" target
❌ SOURCES > "Project" target

⚠️  Only in first (1):

  • Project/Group B/AnotherObjcClass.m


⚠️  Value mismatch (1):

  • Project/Group A/ObjcClass.m compiler flags
    ◦ nil
    ◦ -ObjC


✅ SOURCES > "ProjectFramework" target
❌ SOURCES > "ProjectTests" target

⚠️  Only in first (1):

  • ProjectTests/BarTests.swift


❌ SOURCES > "ProjectUITests" target

⚠️  Only in first (1):

  • ProjectUITests/LoginTests.swift


⚠️  Only in second (1):

  • ProjectUITests/MetricsTests.swift


✅ RESOURCES > "MismatchingLibrary" target
❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • Project/Group B/AViewController.xib
  • Project/Resources/time.png


✅ RESOURCES > "ProjectFramework" target
❌ RESOURCES > "ProjectTests" target

⚠️  Only in second (1):

  • ProjectTests/Responses/ListResponse.json


❌ RESOURCES > "ProjectUITests" target

⚠️  Only in first (1):

  • ProjectUITests/Screenshots/empty.png


✅ RUN_SCRIPTS > "MismatchingLibrary" target
❌ RUN_SCRIPTS > "Project" target > "Second script" build phase

⚠️  Value mismatch (1):

  • shellScript
    ◦ echo "First Hello, world!"

    ◦ echo "second script"



❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase

⚠️  Value mismatch (2):

  • shellScript
    ◦ echo "Hello, World!"

    ◦ echo "Hello, world?"


  • showEnvVarsInLog
    ◦ true
    ◦ false


✅ RUN_SCRIPTS > "ProjectFramework" target
✅ RUN_SCRIPTS > "ProjectTests" target
✅ RUN_SCRIPTS > "ProjectUITests" target
❌ CONFIGURATIONS > Root project

⚠️  Only in second (1):

  • CUSTOM_NEW


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


❌ SOURCE_TREES > Root project
Output format: (<path>, <name>, <source_tree>)

⚠️  Only in first (8):

  • (AViewController.xib, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (AnotherObjcClass.h, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (AnotherObjcClass.m, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (BarTests.swift, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)
  • (LoginTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (empty.png, nil, <group>) → (Screenshots, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (libMismatchingLibrary.a, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)
  • (time.png, nil, <group>) → (Resources, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)


⚠️  Only in second (11):

  • (Header4.h, nil, <group>) → (ProjectFramework, nil, <group>) → (nil, nil, <group>)
  • (Info.plist, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)
  • (ListResponse.json, nil, <group>) → (Responses, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)
  • (MetricsTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (MismatchingLibrary-Info.plist, nil, <group>) → (MismatchingLibrary, nil, <group>) → (nil, nil, <group>)
  • (MismatchingLibrary.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)
  • (NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)
  • (NewFramework.h, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)
  • (Project.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (README.md, nil, <group>) → (nil, nil, <group>)
  • (Target.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)


✅ DEPENDENCIES > "MismatchingLibrary" target
❌ DEPENDENCIES > "Project" target

⚠️  Only in second (2):

  • (target=MismatchingLibrary)
  • (target=NewFramework)


✅ DEPENDENCIES > "ProjectFramework" target
✅ DEPENDENCIES > "ProjectTests" target
✅ DEPENDENCIES > "ProjectUITests" target
✅ LINKED_DEPENDENCIES > "MismatchingLibrary" target
❌ LINKED_DEPENDENCIES > "Project" target

⚠️  Only in second (2):

  • MismatchingLibrary.framework
  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


✅ LINKED_DEPENDENCIES > "ProjectFramework" target
✅ LINKED_DEPENDENCIES > "ProjectTests" target
✅ LINKED_DEPENDENCIES > "ProjectUITests" target
❌ ATTRIBUTES > Root project

⚠️  Value mismatch (3):

  • LastSwiftUpdateCheck
    ◦ 1110
    ◦ 1030

  • LastUpgradeCheck
    ◦ 1020
    ◦ 1030

  • ORGANIZATIONNAME
    ◦ Bloomberg LP
    ◦ Another Organization


❌ ATTRIBUTES > "MismatchingLibrary" target

⚠️  Only in second (1):

  • LastSwiftMigration = 1110


❌ ATTRIBUTES > "Project" target

⚠️  Value mismatch (1):

  • LastSwiftMigration
    ◦ 1140
    ◦ 1020


✅ ATTRIBUTES > "ProjectFramework" target
✅ ATTRIBUTES > "ProjectTests" target
❌ ATTRIBUTES > "ProjectUITests" target

⚠️  Only in second (1):

  • TestTargetID = Project


✅ SWIFT_PACKAGES


```
