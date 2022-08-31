# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "run_scripts", "-f", "console"]
```

# Expected exit code
2

# Expected output
```
✅ RUN_SCRIPTS > "MismatchingLibrary" target
❌ RUN_SCRIPTS > "Project" target > "Second script" build phase
❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase
✅ RUN_SCRIPTS > "ProjectFramework" target
✅ RUN_SCRIPTS > "ProjectTests" target
✅ RUN_SCRIPTS > "ProjectUITests" target


```
