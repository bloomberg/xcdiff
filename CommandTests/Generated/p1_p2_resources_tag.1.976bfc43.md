# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "resources"]
```

# Expected exit code
1

# Expected output
```
❌ RESOURCES > "Project" target
✅ RESOURCES > "ProjectFramework" target
❌ RESOURCES > "ProjectTests" target
❌ RESOURCES > "ProjectUITests" target


```
