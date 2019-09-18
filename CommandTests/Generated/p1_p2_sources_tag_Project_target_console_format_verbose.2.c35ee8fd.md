# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "sources", "-t", "Project", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ SOURCES > "Project" target

⚠️  Only in first (1):

  • Project/Group B/AnotherObjcClass.m


⚠️  Value mismatch (1):

  • Project/Group A/ObjcClass.m compiler flags
    ◦ nil
    ◦ -ObjC




```
