# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "linked_dependencies", "-t", "Project", "-f", "json", "-v"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"Project\" target"
    ],
    "differentValues" : [
      {
        "context" : "ARKit.framework attributes",
        "first" : "required",
        "second" : "optional"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary.framework",
      "NewFramework.framework"
    ],
    "tag" : "linked_dependencies"
  }
]

```
