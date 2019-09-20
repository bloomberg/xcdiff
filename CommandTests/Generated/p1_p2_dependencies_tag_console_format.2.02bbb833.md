# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
❌ DEPENDENCIES > "Project" target > Linked Dependencies
❌ DEPENDENCIES > "Project" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectFramework" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectFramework" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectTests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectTests" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectUITests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectUITests" target > Embedded Frameworks


```
