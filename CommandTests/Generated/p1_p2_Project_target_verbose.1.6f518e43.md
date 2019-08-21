# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-v"]
```

# Expected exit code
1

# Expected output
```
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
