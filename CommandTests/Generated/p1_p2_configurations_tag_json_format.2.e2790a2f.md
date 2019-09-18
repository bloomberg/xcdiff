# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "configurations", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "Root project"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "CUSTOM_NEW"
    ],
    "tag" : "configurations"
  }
]

```
