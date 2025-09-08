# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "plists", "-f", "markdown"]
```

# Expected exit code
2

# Expected output
```

## ❌ PLISTS > "MismatchingLibrary" target


## ❌ PLISTS > "Project" target


## ❌ PLISTS > "Project" target > Info.plist - Info.plist


## ✅ PLISTS > "ProjectFramework" target > Info.plist - Info.plist


## ✅ PLISTS > "ProjectTests" target > Info.plist - Info.plist


## ✅ PLISTS > "ProjectUITests" target > Info.plist - Info.plist



```
