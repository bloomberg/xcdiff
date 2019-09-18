# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-t", "Project", "-f", "markdown"]
```

# Expected exit code
2

# Expected output
```

## ❌ SETTINGS > Root project > "Debug" configuration > Base configuration


## ❌ SETTINGS > Root project > "Debug" configuration > Values


## ✅ SETTINGS > Root project > "Release" configuration > Base configuration


## ❌ SETTINGS > Root project > "Release" configuration > Values


## ❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Debug" configuration > Values


## ✅ SETTINGS > "Project" target > "Release" configuration > Base configuration


## ❌ SETTINGS > "Project" target > "Release" configuration > Values



```
