# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-d"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES
❌ TARGETS > NATIVE targets
❌ TARGETS > AGGREGATE targets
❌ HEADERS > "ProjectFramework" target
❌ SOURCES > "Project" target
❌ SOURCES > "ProjectTests" target
❌ SOURCES > "ProjectUITests" target
❌ RESOURCES > "Project" target
❌ RESOURCES > "ProjectTests" target
❌ RESOURCES > "ProjectUITests" target
❌ CONFIGURATIONS > Root project
❌ SETTINGS > Root project > "Debug" configuration > Base configuration
❌ SETTINGS > Root project > "Debug" configuration > Values
❌ SETTINGS > Root project > "Release" configuration > Values
❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration
❌ SETTINGS > "Project" target > "Debug" configuration > Values
❌ SETTINGS > "Project" target > "Release" configuration > Values
❌ SOURCE_TREES > Root project
❌ DEPENDENCIES > "Project" target > Linked Dependencies
❌ DEPENDENCIES > "Project" target > Embedded Frameworks


```
