# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-t", "Project", "-f", "json", "-v"]
```

# Expected exit code
0

# Expected output
```
[
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "headers"
  }
]

```
