# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "console", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ DEPENDENCIES > "Project" target > Linked Dependencies

⚠️  Only in second (1):

  • NewFramework.framework


⚠️  Value mismatch (1):

  • ARKit.framework attributes
    ◦ required
    ◦ optional


❌ DEPENDENCIES > "Project" target > Embedded Frameworks

⚠️  Only in second (1):

  • NewFramework.framework


✅ DEPENDENCIES > "ProjectFramework" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectFramework" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectTests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectTests" target > Embedded Frameworks
✅ DEPENDENCIES > "ProjectUITests" target > Linked Dependencies
✅ DEPENDENCIES > "ProjectUITests" target > Embedded Frameworks


```
