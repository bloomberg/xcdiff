# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ HEADERS > "MismatchingLibrary" target


### ⚠️  Only in second (1):

  - `MismatchingLibrary/MismatchingLibrary.h`



## ✅ HEADERS > "Project" target


## ❌ HEADERS > "ProjectFramework" target


### ⚠️  Only in second (1):

  - `ProjectFramework/Header4.h`


### ⚠️  Value mismatch (2):

  - `ProjectFramework/Header1.h attributes`
    - `Public`
    - `nil (Project)`

  - `ProjectFramework/Header2.h attributes`
    - `Private`
    - `nil (Project)`



## ✅ HEADERS > "ProjectTests" target


## ✅ HEADERS > "ProjectUITests" target



```
