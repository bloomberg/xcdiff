# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "plists", "-t", "Project", "-f", "json", "-v"]
```

# Expected exit code
0

# Expected output
```
[
  {
    "context" : [
      "Info.plist",
      "Info.plist"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "plists"
  }
]

```
