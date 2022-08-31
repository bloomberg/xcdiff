# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-d"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES
❌ BUILD_PHASES > "MismatchingLibrary" target
❌ COPY_FILES > "Project" target > Embed Frameworks
❌ TARGETS > NATIVE targets
❌ TARGETS > AGGREGATE targets
❌ HEADERS > "MismatchingLibrary" target
❌ HEADERS > "ProjectFramework" target
❌ SOURCES > "Project" target
❌ SOURCES > "ProjectTests" target
❌ SOURCES > "ProjectUITests" target
❌ RESOURCES > "Project" target
❌ RESOURCES > "ProjectTests" target
❌ RESOURCES > "ProjectUITests" target
❌ RUN_SCRIPTS > "Project" target > "Second script" build phase
❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase
❌ CONFIGURATIONS > Root project
❌ SETTINGS > Root project > "Debug" configuration > Base configuration
❌ SETTINGS > Root project > "Debug" configuration > Values
❌ SETTINGS > Root project > "Release" configuration > Values
❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values
❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values
❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration
❌ SETTINGS > "Project" target > "Debug" configuration > Values
❌ SETTINGS > "Project" target > "Release" configuration > Values
❌ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values
❌ SETTINGS > "ProjectFramework" target > "Release" configuration > Values
❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values
❌ SOURCE_TREES > Root project
❌ DEPENDENCIES > "Project" target
❌ LINKED_DEPENDENCIES > "Project" target
❌ ATTRIBUTES > Root project
❌ ATTRIBUTES > "MismatchingLibrary" target
❌ ATTRIBUTES > "Project" target
❌ ATTRIBUTES > "ProjectUITests" target


```
