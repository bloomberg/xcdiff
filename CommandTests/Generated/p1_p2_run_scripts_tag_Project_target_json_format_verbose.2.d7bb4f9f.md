# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "run_scripts", "-t", "Project", "-f", "json", "-v"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"Project\" target",
      "\"Second script\" build phase"
    ],
    "differentValues" : [
      {
        "context" : "shellScript",
        "first" : "echo \"First Hello, world!\"\n",
        "second" : "echo \"second script\"\n"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "run_scripts"
  },
  {
    "context" : [
      "\"Project\" target",
      "\"ShellScript\" build phase"
    ],
    "differentValues" : [
      {
        "context" : "shellScript",
        "first" : "echo \"Hello, World!\"\n",
        "second" : "echo \"Hello, world?\"\n"
      },
      {
        "context" : "showEnvVarsInLog",
        "first" : "true",
        "second" : "false"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "run_scripts"
  }
]

```
