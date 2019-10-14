# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-v"]
```

# Expected exit code
2

# Expected output
```
✅ HEADERS > "Project" target
❌ HEADERS > "ProjectFramework" target

⚠️  Only in second (1):

  • ProjectFramework/Header4.h


⚠️  Value mismatch (2):

  • ProjectFramework/Header1.h attributes
    ◦ Public
    ◦ Project

  • ProjectFramework/Header2.h attributes
    ◦ Private
    ◦ Project


✅ HEADERS > "ProjectTests" target
✅ HEADERS > "ProjectUITests" target


```
