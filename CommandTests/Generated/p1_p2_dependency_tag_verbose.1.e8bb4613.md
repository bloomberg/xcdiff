# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependency", "-v"]
```

# Expected exit code
1

# Expected output
```
❌ DEPENDENCY > "Project" target

⚠️  Only in second (1):

  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


✅ DEPENDENCY > "ProjectFramework" target
✅ DEPENDENCY > "ProjectTests" target
✅ DEPENDENCY > "ProjectUITests" target


```
