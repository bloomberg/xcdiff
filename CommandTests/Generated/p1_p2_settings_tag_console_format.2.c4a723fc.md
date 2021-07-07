# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "settings", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
❌ SETTINGS > Root project > "Debug" configuration > Base configuration
❌ SETTINGS > Root project > "Debug" configuration > Values
✅ SETTINGS > Root project > "Release" configuration > Base configuration
❌ SETTINGS > Root project > "Release" configuration > Values
✅ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values
✅ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Base configuration
❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values
❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration
❌ SETTINGS > "Project" target > "Debug" configuration > Values
✅ SETTINGS > "Project" target > "Release" configuration > Base configuration
❌ SETTINGS > "Project" target > "Release" configuration > Values
✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration
❌ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration
❌ SETTINGS > "ProjectFramework" target > "Release" configuration > Values
✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration
❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values


```
