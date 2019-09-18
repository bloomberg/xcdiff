# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ DEPENDENCIES > "Project" target


### ⚠️  Only in second (1):

  - `NewFramework.framework`


### ⚠️  Value mismatch (1):

  - `ARKit.framework attributes`
    - `required`
    - `optional`



## ✅ DEPENDENCIES > "ProjectFramework" target


## ✅ DEPENDENCIES > "ProjectTests" target


## ✅ DEPENDENCIES > "ProjectUITests" target



```
