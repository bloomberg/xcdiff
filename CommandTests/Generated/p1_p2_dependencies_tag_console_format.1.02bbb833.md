# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "console"]
```

# Expected exit code
1

# Expected output
```
❌ DEPENDENCIES > "Project" target
✅ DEPENDENCIES > "ProjectFramework" target
✅ DEPENDENCIES > "ProjectTests" target
✅ DEPENDENCIES > "ProjectUITests" target


```
