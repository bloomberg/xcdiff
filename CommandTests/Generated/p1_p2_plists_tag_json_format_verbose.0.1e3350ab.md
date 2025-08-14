# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "plists", "-f", "json", "-v"]
```

# Expected exit code
0

# Expected output
```
[
  {
    "context" : [
      "MismatchingLibrary-Info.plist"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "plists"
  },
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
  },
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
  },
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
  },
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
