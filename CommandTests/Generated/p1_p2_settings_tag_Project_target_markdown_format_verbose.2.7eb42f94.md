# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-t", "Project", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ SETTINGS > Root project > "Debug" configuration > Base configuration


### ⚠️  Value mismatch (1):

  - `Path to .xcconfig`
    - `nil`
    - `Project/Project.xcconfig`



## ❌ SETTINGS > Root project > "Debug" configuration > Values


### ⚠️  Only in second (1):

  - `CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL`



## ✅ SETTINGS > Root project > "Release" configuration > Base configuration


## ❌ SETTINGS > Root project > "Release" configuration > Values


### ⚠️  Only in second (1):

  - `CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL`



## ❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration


### ⚠️  Value mismatch (1):

  - `Path to .xcconfig`
    - `nil`
    - `Project/Target.xcconfig`



## ❌ SETTINGS > "Project" target > "Debug" configuration > Values


### ⚠️  Only in second (1):

  - `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES`


### ⚠️  Value mismatch (1):

  - `CUSTOM_SETTING_COMMON`
    - `VALUE_1`
    - `VALUE_2`



## ✅ SETTINGS > "Project" target > "Release" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Release" configuration > Values


### ⚠️  Only in second (1):

  - `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES`


### ⚠️  Value mismatch (1):

  - `CUSTOM_SETTING_COMMON`
    - `VALUE_1`
    - `VALUE_2`




```
