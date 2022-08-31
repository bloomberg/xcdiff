# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-v"]
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


✅ BUILD_PHASES > "Project" target
❌ COPY_FILES > "Project" target > Embed Frameworks

⚠️  Only in second (2):

  • MismatchingLibrary.framework
  • NewFramework.framework


⚠️  Value mismatch (1):

  • ProjectFramework.framework
    ◦ attributes = ["CodeSignOnCopy", "RemoveHeadersOnCopy"]
    ◦ attributes = []


✅ TARGETS > NATIVE targets
✅ TARGETS > AGGREGATE targets
✅ HEADERS > "Project" target
❌ SOURCES > "Project" target

⚠️  Only in first (1):

  • Project/Group B/AnotherObjcClass.m


⚠️  Value mismatch (1):

  • Project/Group A/ObjcClass.m compiler flags
    ◦ nil
    ◦ -ObjC


❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • Project/Group B/AViewController.xib
  • Project/Resources/time.png


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


❌ DEPENDENCIES > "Project" target

⚠️  Only in second (2):

  • (target=MismatchingLibrary)
  • (target=NewFramework)


❌ LINKED_DEPENDENCIES > "Project" target

⚠️  Only in second (2):

  • MismatchingLibrary.framework
  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


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


❌ ATTRIBUTES > "Project" target

⚠️  Value mismatch (1):

  • LastSwiftMigration
    ◦ 1140
    ◦ 1020


✅ SWIFT_PACKAGES


```
