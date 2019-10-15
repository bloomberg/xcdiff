# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "resources", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
✅ RESOURCES > "MismatchingLibrary" target
❌ RESOURCES > "Project" target

⚠️  Only in first (2):

  • Project/Group B/AViewController.xib
  • Project/Resources/time.png


✅ RESOURCES > "ProjectFramework" target
❌ RESOURCES > "ProjectTests" target

⚠️  Only in second (1):

  • ProjectTests/Responses/ListResponse.json


❌ RESOURCES > "ProjectUITests" target

⚠️  Only in first (1):

  • ProjectUITests/Screenshots/empty.png




```
