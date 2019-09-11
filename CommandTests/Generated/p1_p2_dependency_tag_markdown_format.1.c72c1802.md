# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependency", "-f", "markdown"]
```

# Expected exit code
1

# Expected output
```

## ❌ DEPENDENCY > "Project" target


## ✅ DEPENDENCY > "ProjectFramework" target


## ✅ DEPENDENCY > "ProjectTests" target


## ✅ DEPENDENCY > "ProjectUITests" target



```
