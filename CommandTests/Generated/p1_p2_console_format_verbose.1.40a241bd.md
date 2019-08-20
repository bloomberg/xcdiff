# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "console", "-v"]
```

# Expected exit code
1

# Expected output
```
❌ TARGETS > NATIVE targets

⚠️  Only in second (1):

  • NewFramework


❌ TARGETS > AGGREGATE targets

⚠️  Only in second (1):

  • NewAggregate


❌ SOURCES > "Project" target

⚠️  Only in first (1):

  • /Project/Group B/AnotherObjcClass.m


⚠️  Value mismatch (1):

  • /Project/Group A/ObjcClass.m compiler flags
    ◦ -ObjC


❌ SOURCES > "ProjectTests" target

⚠️  Only in first (1):

  • /ProjectTests/BarTests.swift


❌ SOURCES > "ProjectUITests" target

⚠️  Only in first (1):

  • /ProjectUITests/LoginTests.swift


⚠️  Only in second (1):

  • /ProjectUITests/MetricsTests.swift


❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • /Project/Group B/AViewController.xib
  • /Project/Resources/time.png


❌ RESOURCES > "ProjectTests" target

⚠️  Only in second (1):

  • /ProjectTests/Responses/ListResponse.json


❌ RESOURCES > "ProjectUITests" target

⚠️  Only in first (1):

  • /ProjectUITests/Screenshots/empty.png




```
