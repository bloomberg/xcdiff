# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "markdown"]
```

# Expected exit code
2

# Expected output
```

## ✅ DEPENDENCIES > "MismatchingLibrary" target


## ❌ DEPENDENCIES > "Project" target


## ✅ DEPENDENCIES > "ProjectFramework" target


## ✅ DEPENDENCIES > "ProjectTests" target


## ✅ DEPENDENCIES > "ProjectUITests" target



```
