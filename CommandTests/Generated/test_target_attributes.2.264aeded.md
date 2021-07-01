# Command
```json
["-p1", "{ios_project_with_ui_tests_1}", "-p2", "{ios_project_with_ui_tests_2}", "-g", "attributes", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ ATTRIBUTES > Root project

⚠️  Only in first (1):

  • ORGANIZATIONNAME = MyOrg


⚠️  Only in second (1):

  • LastSwiftUpdateCheck = 1240


⚠️  Value mismatch (1):

  • LastUpgradeCheck
    ◦ 1240
    ◦ 1250


✅ ATTRIBUTES > "MyApp" target
❌ ATTRIBUTES > "MyAppUITests" target

⚠️  Value mismatch (1):

  • CreatedOnToolsVersion
    ◦ 12.4
    ◦ 12.5




```
