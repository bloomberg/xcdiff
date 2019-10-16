# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "sources", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ✅ SOURCES > "MismatchingLibrary" target


## ❌ SOURCES > "Project" target


### ⚠️  Only in first (1):

  - `Project/Group B/AnotherObjcClass.m`


### ⚠️  Value mismatch (1):

  - `Project/Group A/ObjcClass.m compiler flags`
    - `nil`
    - `-ObjC`



## ✅ SOURCES > "ProjectFramework" target


## ❌ SOURCES > "ProjectTests" target


### ⚠️  Only in first (1):

  - `ProjectTests/BarTests.swift`



## ❌ SOURCES > "ProjectUITests" target


### ⚠️  Only in first (1):

  - `ProjectUITests/LoginTests.swift`


### ⚠️  Only in second (1):

  - `ProjectUITests/MetricsTests.swift`




```
