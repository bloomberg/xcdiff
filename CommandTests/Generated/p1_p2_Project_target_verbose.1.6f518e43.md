# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-v"]
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


⚠️  Only in second (7):

  • NewFramework.framework
  • NewFramework/Info.plist
  • NewFramework/NewFramework.h
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
    ◦ -ObjC


❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • /Project/Group B/AViewController.xib
  • /Project/Resources/time.png




```
