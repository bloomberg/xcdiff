# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-f", "console", "-v"]
```

# Expected exit code
1

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


✅ TARGETS > NATIVE targets
✅ TARGETS > AGGREGATE targets
✅ HEADERS > "Project" target
❌ SOURCES > "Project" target

⚠️  Only in first (1):

  • /Project/Group B/AnotherObjcClass.m


⚠️  Value mismatch (1):

  • /Project/Group A/ObjcClass.m compiler flags
    ◦ nil
    ◦ -ObjC


❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • /Project/Group B/AViewController.xib
  • /Project/Resources/time.png


❌ CONFIGURATIONS > Root project

⚠️  Only in second (1):

  • CUSTOM_NEW


❌ SETTINGS > Root project > "Debug" configuration > Base configuration

⚠️  Value mismatch (1):

  • Path to .xcconfig
    ◦ nil
    ◦ /Project/Project.xcconfig


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
    ◦ /Project/Target.xcconfig


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




```
