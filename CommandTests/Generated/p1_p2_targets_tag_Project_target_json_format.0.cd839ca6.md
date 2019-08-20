# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "targets", "-t", "Project", "-f", "json"]
```

# Expected exit code
0

# Expected output
```
[
  {
    "context" : [
      "NATIVE targets"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "targets"
  },
  {
    "context" : [
      "AGGREGATE targets"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "targets"
  }
]

```
