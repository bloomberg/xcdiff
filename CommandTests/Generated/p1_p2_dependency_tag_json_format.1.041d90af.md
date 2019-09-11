# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependency", "-f", "json"]
```

# Expected exit code
1

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
      "NewFramework.framework"
    ],
    "tag" : "dependency"
  },
  {
    "context" : [
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependency"
  },
  {
    "context" : [
      "\"ProjectTests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependency"
  },
  {
    "context" : [
      "\"ProjectUITests\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependency"
  }
]

```
