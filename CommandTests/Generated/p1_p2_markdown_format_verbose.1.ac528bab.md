# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "markdown", "-v"]
```

# Expected exit code
1

# Expected output
```

## ❌ FILE_REFERENCES


### ⚠️  Only in first (7):

  - `Project/Group B/AViewController.xib`
  - `Project/Group B/AnotherObjcClass.h`
  - `Project/Group B/AnotherObjcClass.m`
  - `Project/Resources/time.png`
  - `ProjectTests/BarTests.swift`
  - `ProjectUITests/LoginTests.swift`
  - `ProjectUITests/Screenshots/empty.png`


### ⚠️  Only in second (9):

  - `NewFramework.framework`
  - `NewFramework/Info.plist`
  - `NewFramework/NewFramework.h`
  - `Project/Project.xcconfig`
  - `Project/Target.xcconfig`
  - `ProjectFramework/Header4.h`
  - `ProjectTests/Responses/ListResponse.json`
  - `ProjectUITests/MetricsTests.swift`
  - `README.md`



## ❌ TARGETS > NATIVE targets


### ⚠️  Only in second (1):

  - `NewFramework`



## ❌ TARGETS > AGGREGATE targets


### ⚠️  Only in second (1):

  - `NewAggregate`



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



## ❌ RESOURCES > "Project" target


### ⚠️  Only in first (2):

  - `Project/Group B/AViewController.xib`
  - `Project/Resources/time.png`



## ✅ RESOURCES > "ProjectFramework" target


## ❌ RESOURCES > "ProjectTests" target


### ⚠️  Only in second (1):

  - `ProjectTests/Responses/ListResponse.json`



## ❌ RESOURCES > "ProjectUITests" target


### ⚠️  Only in first (1):

  - `ProjectUITests/Screenshots/empty.png`



## ❌ CONFIGURATIONS > Root project


### ⚠️  Only in second (1):

  - `CUSTOM_NEW`



## ❌ SETTINGS > Root project > "Debug" configuration > Base configuration


### ⚠️  Value mismatch (1):

  - `Path to .xcconfig`
    - `nil`
    - `Project/Project.xcconfig`



## ❌ SETTINGS > Root project > "Debug" configuration > Values


### ⚠️  Only in second (1):

  - `CUSTOM_SETTGING_1`



## ✅ SETTINGS > Root project > "Release" configuration > Base configuration


## ❌ SETTINGS > Root project > "Release" configuration > Values


### ⚠️  Only in second (1):

  - `CUSTOM_SETTGING_1`



## ❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration


### ⚠️  Value mismatch (1):

  - `Path to .xcconfig`
    - `nil`
    - `Project/Target.xcconfig`



## ❌ SETTINGS > "Project" target > "Debug" configuration > Values


### ⚠️  Value mismatch (1):

  - `CUSTOM_SETTING_COMMON`
    - `VALUE_1`
    - `VALUE_2`



## ✅ SETTINGS > "Project" target > "Release" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Release" configuration > Values


### ⚠️  Value mismatch (1):

  - `CUSTOM_SETTING_COMMON`
    - `VALUE_1`
    - `VALUE_2`



## ✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration


## ✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values


## ✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration


## ✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Values


## ✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration


## ✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values


## ✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration


## ✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values


## ✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration


## ✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values


## ✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration


## ✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Values



```
