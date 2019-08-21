# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "markdown"]
```

# Expected exit code
1

# Expected output
```

## ❌ TARGETS > NATIVE targets


## ❌ TARGETS > AGGREGATE targets


## ✅ HEADERS > "Project" target


## ❌ HEADERS > "ProjectFramework" target


## ✅ HEADERS > "ProjectTests" target


## ✅ HEADERS > "ProjectUITests" target


## ❌ SOURCES > "Project" target


## ✅ SOURCES > "ProjectFramework" target


## ❌ SOURCES > "ProjectTests" target


## ❌ SOURCES > "ProjectUITests" target


## ❌ RESOURCES > "Project" target


## ✅ RESOURCES > "ProjectFramework" target


## ❌ RESOURCES > "ProjectTests" target


## ❌ RESOURCES > "ProjectUITests" target



```
