# Command
```json
["-p1", "{ios_project_with_swift_packages_1}", "-p2", "{ios_project_with_swift_packages_2}", "-v"]
```

# Expected exit code
2

# Expected output
```
✅ FILE_REFERENCES
✅ BUILD_PHASES > "App" target
✅ COPY_FILES > "App" target
✅ TARGETS > NATIVE targets
✅ TARGETS > AGGREGATE targets
✅ HEADERS > "App" target
✅ SOURCES > "App" target
✅ RESOURCES > "App" target
✅ RUN_SCRIPTS > "App" target
✅ CONFIGURATIONS > Root project
✅ SETTINGS > Root project > "Debug" configuration > Base configuration
✅ SETTINGS > Root project > "Debug" configuration > Values
✅ SETTINGS > Root project > "Release" configuration > Base configuration
✅ SETTINGS > Root project > "Release" configuration > Values
✅ SETTINGS > "App" target > "Debug" configuration > Base configuration
✅ SETTINGS > "App" target > "Debug" configuration > Values
✅ SETTINGS > "App" target > "Release" configuration > Base configuration
✅ SETTINGS > "App" target > "Release" configuration > Values
✅ SOURCE_TREES > Root project
✅ DEPENDENCIES > "App" target
❌ LINKED_DEPENDENCIES > "App" target

⚠️  Only in second (1):

  • Swinject


⚠️  Value mismatch (2):

  • ComposableArchitecture package reference
    ◦ version = .upToNextMajorVersion(0.9.0)
    ◦ version = .upToNextMinorVersion(0.9.0)

  • Swifter package reference
    ◦ swifter (https://github.com/httpswift/swifter.git) .upToNextMajorVersion(1.5.0)
    ◦ nil


✅ ATTRIBUTES > Root project
✅ ATTRIBUTES > "App" target
❌ SWIFT_PACKAGES

⚠️  Only in second (1):

  • Swinject (https://github.com/Swinject/Swinject.git) .upToNextMajorVersion(2.7.1)


⚠️  Value mismatch (1):

  • swift-composable-architecture (https://github.com/pointfreeco/swift-composable-architecture.git)
    ◦ version = .upToNextMajorVersion(0.9.0)
    ◦ version = .upToNextMinorVersion(0.9.0)




```
