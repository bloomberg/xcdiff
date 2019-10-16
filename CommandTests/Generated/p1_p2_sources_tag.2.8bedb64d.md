# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "sources"]
```

# Expected exit code
2

# Expected output
```
✅ SOURCES > "MismatchingLibrary" target
❌ SOURCES > "Project" target
✅ SOURCES > "ProjectFramework" target
❌ SOURCES > "ProjectTests" target
❌ SOURCES > "ProjectUITests" target


```
