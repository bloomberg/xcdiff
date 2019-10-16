# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
❌ HEADERS > "MismatchingLibrary" target
✅ HEADERS > "Project" target
❌ HEADERS > "ProjectFramework" target
✅ HEADERS > "ProjectTests" target
✅ HEADERS > "ProjectUITests" target


```
