# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "run_scripts", "-t", "Project", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ RUN_SCRIPTS > "Project" target > "Second script" build phase


### ⚠️  Value mismatch (1):

  - `shellScript`
    - `echo "First Hello, world!"
`
    - `echo "second script"
`



## ❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase


### ⚠️  Value mismatch (2):

  - `shellScript`
    - `echo "Hello, World!"
`
    - `echo "Hello, world?"
`

  - `showEnvVarsInLog`
    - `true`
    - `false`




```
