# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "linked_dependencies", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ✅ LINKED_DEPENDENCIES > "MismatchingLibrary" target


## ❌ LINKED_DEPENDENCIES > "Project" target


### ⚠️  Only in second (2):

  - `MismatchingLibrary.framework`
  - `NewFramework.framework`


### ⚠️  Value mismatch (1):

  - `ARKit.framework attributes`
    - `required`
    - `optional`



## ✅ LINKED_DEPENDENCIES > "ProjectFramework" target


## ✅ LINKED_DEPENDENCIES > "ProjectTests" target


## ✅ LINKED_DEPENDENCIES > "ProjectUITests" target



```
