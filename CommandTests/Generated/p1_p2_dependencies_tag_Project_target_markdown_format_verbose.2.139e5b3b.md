# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-t", "Project", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ DEPENDENCIES > "Project" target > Linked Dependencies


### ⚠️  Only in second (2):

  - `MismatchingLibrary.framework`
  - `NewFramework.framework`


### ⚠️  Value mismatch (1):

  - `ARKit.framework attributes`
    - `required`
    - `optional`



## ❌ DEPENDENCIES > "Project" target > Embedded Frameworks


### ⚠️  Only in second (2):

  - `MismatchingLibrary.framework`
  - `NewFramework.framework`


### ⚠️  Value mismatch (1):

  - `ProjectFramework.framework Code Sign on Copy`
    - `true`
    - `false`




```
