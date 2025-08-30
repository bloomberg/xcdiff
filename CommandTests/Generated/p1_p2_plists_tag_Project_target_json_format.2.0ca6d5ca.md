# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "plists", "-t", "Project", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "Project.entitlements"
    ],
    "tag" : "plists"
  },
  {
    "context" : [
      "\"Project\" target",
      "Info.plist - Info.plist"
    ],
    "differentValues" : [
      {
        "context" : "UIApplicationSceneManifest.UISceneConfigurations.UIWindowSceneSessionRoleApplication[0].UISceneDelegateClassName",
        "first" : "$(PRODUCT_BUNDLE_IDENTIFIER).AppSceneDelegate",
        "second" : "$(PRODUCT_MODULE_NAME).AppSceneDelegate"
      },
      {
        "context" : "UIBackgroundModes[0]",
        "first" : "fetch",
        "second" : "remote-notification"
      },
      {
        "context" : "UIRequiredDeviceCapabilities[0]",
        "first" : "bluetooth-le",
        "second" : "armv7"
      }
    ],
    "onlyInFirst" : [
      "LSApplicationCategoryType",
      "fetch",
      "voip",
      "bluetooth-le"
    ],
    "onlyInSecond" : [
      "UISceneConfigurationName",
      "remote-notification"
    ],
    "tag" : "plists"
  }
]

```
