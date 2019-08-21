# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-f", "markdown"]
```

# Expected exit code
1

# Expected output
```

## ✅ HEADERS > "Project" target


## ❌ HEADERS > "ProjectFramework" target


## ✅ HEADERS > "ProjectTests" target


## ✅ HEADERS > "ProjectUITests" target



```
