# Command
```json
["-p1", "{xcode16_syncgroups_1}", "-p2", "{xcode16_syncgroups_2}", "-g", "filesystem_synchronized_groups", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ FILESYSTEM_SYNCHRONIZED_GROUPS > "Project" target

⚠️  Only in second (1):

  • AnotherSourceFolder


✅ FILESYSTEM_SYNCHRONIZED_GROUPS > "ProjectTests" target
✅ FILESYSTEM_SYNCHRONIZED_GROUPS > "ProjectUITests" target


```
