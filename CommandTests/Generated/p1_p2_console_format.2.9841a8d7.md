# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
❌ FILE_REFERENCES
❌ BUILD_PHASES > "MismatchingLibrary" target
✅ BUILD_PHASES > "Project" target
✅ BUILD_PHASES > "ProjectFramework" target
✅ BUILD_PHASES > "ProjectTests" target
✅ BUILD_PHASES > "ProjectUITests" target
✅ COPY_FILES > "MismatchingLibrary" target
❌ COPY_FILES > "Project" target > Embed Frameworks
✅ COPY_FILES > "ProjectFramework" target
✅ COPY_FILES > "ProjectTests" target
✅ COPY_FILES > "ProjectUITests" target
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
✅ RUN_SCRIPTS > "MismatchingLibrary" target
❌ RUN_SCRIPTS > "Project" target > "Second script" build phase
❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase
✅ RUN_SCRIPTS > "ProjectFramework" target
✅ RUN_SCRIPTS > "ProjectTests" target
✅ RUN_SCRIPTS > "ProjectUITests" target
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
❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values
✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration
❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values
❌ SOURCE_TREES > Root project
✅ DEPENDENCIES > "MismatchingLibrary" target
❌ DEPENDENCIES > "Project" target
✅ DEPENDENCIES > "ProjectFramework" target
✅ DEPENDENCIES > "ProjectTests" target
✅ DEPENDENCIES > "ProjectUITests" target
✅ LINKED_DEPENDENCIES > "MismatchingLibrary" target
❌ LINKED_DEPENDENCIES > "Project" target
✅ LINKED_DEPENDENCIES > "ProjectFramework" target
✅ LINKED_DEPENDENCIES > "ProjectTests" target
✅ LINKED_DEPENDENCIES > "ProjectUITests" target
❌ ATTRIBUTES > Root project
❌ ATTRIBUTES > "MismatchingLibrary" target
❌ ATTRIBUTES > "Project" target
✅ ATTRIBUTES > "ProjectFramework" target
✅ ATTRIBUTES > "ProjectTests" target
❌ ATTRIBUTES > "ProjectUITests" target
✅ SWIFT_PACKAGES


```
