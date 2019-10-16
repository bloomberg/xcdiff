# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES
❌ TARGETS > NATIVE targets
❌ TARGETS > AGGREGATE targets
❌ HEADERS > "MismatchingLibrary" target
✅ HEADERS > "Project" target
❌ HEADERS > "ProjectFramework" target
✅ HEADERS > "ProjectTests" target
✅ HEADERS > "ProjectUITests" target
✅ SOURCES > "MismatchingLibrary" target
❌ SOURCES > "Project" target
✅ SOURCES > "ProjectFramework" target
❌ SOURCES > "ProjectTests" target
❌ SOURCES > "ProjectUITests" target
✅ RESOURCES > "MismatchingLibrary" target
❌ RESOURCES > "Project" target
✅ RESOURCES > "ProjectFramework" target
❌ RESOURCES > "ProjectTests" target
❌ RESOURCES > "ProjectUITests" target
❌ CONFIGURATIONS > Root project
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
✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Values
❌ SOURCE_TREES > Root project
✅ DEPENDENCIES > "MismatchingLibrary" target > Linked Dependencies
✅ DEPENDENCIES > "MismatchingLibrary" target > Embedded Frameworks
❌ DEPENDENCIES > "Project" target > Linked Dependencies
❌ DEPENDENCIES > "Project" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectFramework" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectFramework" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectTests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectTests" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectUITests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectUITests" target > Embedded Frameworks


```
