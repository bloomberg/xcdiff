# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "Project", "-f", "markdown"]
```

# Expected exit code
2

# Expected output
```

## ❌ FILE_REFERENCES


## ✅ BUILD_PHASES > "Project" target


## ✅ TARGETS > NATIVE targets


## ✅ TARGETS > AGGREGATE targets


## ✅ HEADERS > "Project" target


## ❌ SOURCES > "Project" target


## ❌ RESOURCES > "Project" target


## ❌ CONFIGURATIONS > Root project


## ❌ SETTINGS > Root project > "Debug" configuration > Base configuration


## ❌ SETTINGS > Root project > "Debug" configuration > Values


## ✅ SETTINGS > Root project > "Release" configuration > Base configuration


## ❌ SETTINGS > Root project > "Release" configuration > Values


## ❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Debug" configuration > Values


## ✅ SETTINGS > "Project" target > "Release" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Release" configuration > Values


## ❌ SOURCE_TREES > Root project


## ❌ DEPENDENCIES > "Project" target > Linked Dependencies


## ❌ DEPENDENCIES > "Project" target > Embedded Frameworks



```
