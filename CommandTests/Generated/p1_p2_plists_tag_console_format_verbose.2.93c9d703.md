# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "plists", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ PLISTS > "MismatchingLibrary" target

⚠️  Only in second (1):

  • MismatchingLibrary-Info.plist


❌ PLISTS > "Project" target

⚠️  Only in second (1):

  • Project.entitlements


❌ PLISTS > "Project" target > Info.plist - Info.plist

⚠️  Only in first (1):

  • LSApplicationCategoryType


⚠️  Only in second (1):

  • UISceneConfigurationName


⚠️  Value mismatch (3):

  • UIApplicationSceneManifest.UISceneConfigurations.UIWindowSceneSessionRoleApplication[0].UISceneDelegateClassName
    ◦ $(PRODUCT_BUNDLE_IDENTIFIER).AppSceneDelegate
    ◦ $(PRODUCT_MODULE_NAME).AppSceneDelegate

  • UIBackgroundModes
    ◦ fetch, voip
    ◦ remote-notification

  • UIRequiredDeviceCapabilities
    ◦ bluetooth-le
    ◦ nil


✅ PLISTS > "ProjectFramework" target > Info.plist - Info.plist
✅ PLISTS > "ProjectTests" target > Info.plist - Info.plist
✅ PLISTS > "ProjectUITests" target > Info.plist - Info.plist


```
