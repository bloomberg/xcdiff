# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-t", "Project", "-f", "markdown", "-v"]
```

# Expected exit code
1

# Expected output
```

## ❌ DEPENDENCIES > "Project" target


### ⚠️  Only in second (1):

  - `NewFramework.framework`


### ⚠️  Value mismatch (1):

  - `ARKit.framework attributes`
    - `required`
    - `optional`




```
