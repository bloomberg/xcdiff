# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-v"]
```

# Expected exit code
2

# Expected output
```
✅ DEPENDENCIES > "MismatchingLibrary" target
❌ DEPENDENCIES > "Project" target

⚠️  Only in second (2):

  • MismatchingLibrary.framework
  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


✅ DEPENDENCIES > "ProjectFramework" target
✅ DEPENDENCIES > "ProjectTests" target
✅ DEPENDENCIES > "ProjectUITests" target


```
