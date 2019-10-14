# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES

⚠️  Only in first (7):

  • Project/Group B/AViewController.xib
  • Project/Group B/AnotherObjcClass.h
  • Project/Group B/AnotherObjcClass.m
  • Project/Resources/time.png
  • ProjectTests/BarTests.swift
  • ProjectUITests/LoginTests.swift
  • ProjectUITests/Screenshots/empty.png


⚠️  Only in second (9):

  • NewFramework.framework
  • NewFramework/Info.plist
  • NewFramework/NewFramework.h
  • Project/Project.xcconfig
  • Project/Target.xcconfig
  • ProjectFramework/Header4.h
  • ProjectTests/Responses/ListResponse.json
  • ProjectUITests/MetricsTests.swift
  • README.md


❌ TARGETS > NATIVE targets

⚠️  Only in second (1):

  • NewFramework


❌ TARGETS > AGGREGATE targets

⚠️  Only in second (1):

  • NewAggregate


✅ HEADERS > "Project" target
❌ HEADERS > "ProjectFramework" target

⚠️  Only in second (1):

  • ProjectFramework/Header4.h


⚠️  Value mismatch (2):

  • ProjectFramework/Header1.h attributes
    ◦ Public
    ◦ Project

  • ProjectFramework/Header2.h attributes
    ◦ Private
    ◦ Project


✅ HEADERS > "ProjectTests" target
✅ HEADERS > "ProjectUITests" target
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

  • CUSTOM_SETTGING_1


✅ SETTINGS > Root project > "Release" configuration > Base configuration
❌ SETTINGS > Root project > "Release" configuration > Values

⚠️  Only in second (1):

  • CUSTOM_SETTGING_1


❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration

⚠️  Value mismatch (1):

  • Path to .xcconfig
    ◦ nil
    ◦ Project/Target.xcconfig


❌ SETTINGS > "Project" target > "Debug" configuration > Values

⚠️  Value mismatch (1):

  • CUSTOM_SETTING_COMMON
    ◦ VALUE_1
    ◦ VALUE_2


✅ SETTINGS > "Project" target > "Release" configuration > Base configuration
❌ SETTINGS > "Project" target > "Release" configuration > Values

⚠️  Value mismatch (1):

  • CUSTOM_SETTING_COMMON
    ◦ VALUE_1
    ◦ VALUE_2


✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration
✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Values
✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Values
❌ SOURCE_TREES > Root project
Output format: (<path>, <name>, <source_tree>)

⚠️  Only in first (7):

  • (AViewController.xib, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (AnotherObjcClass.h, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (AnotherObjcClass.m, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (BarTests.swift, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)
  • (LoginTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (empty.png, nil, <group>) → (Screenshots, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (time.png, nil, <group>) → (Resources, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)


⚠️  Only in second (9):

  • (Header4.h, nil, <group>) → (ProjectFramework, nil, <group>) → (nil, nil, <group>)
  • (Info.plist, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)
  • (ListResponse.json, nil, <group>) → (Responses, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)
  • (MetricsTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)
  • (NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)
  • (NewFramework.h, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)
  • (Project.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)
  • (README.md, nil, <group>) → (nil, nil, <group>)
  • (Target.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)


❌ DEPENDENCIES > "Project" target > Linked Dependencies

⚠️  Only in second (1):

  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


❌ DEPENDENCIES > "Project" target > Embedded Frameworks

⚠️  Only in second (1):

  • NewFramework.framework


✅ DEPENDENCIES > "ProjectFramework" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectFramework" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectTests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectTests" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectUITests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectUITests" target > Embedded Frameworks


```
