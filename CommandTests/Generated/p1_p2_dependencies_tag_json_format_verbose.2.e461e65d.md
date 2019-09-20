# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "json", "-v"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"Project\" target",
      "Linked Dependencies"
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
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"Project\" target",
      "Embedded Frameworks"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "NewFramework.framework"
    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectFramework\" target",
      "Linked Dependencies"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectFramework\" target",
      "Embedded Frameworks"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectTests\" target",
      "Linked Dependencies"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectTests\" target",
      "Embedded Frameworks"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectUITests\" target",
      "Linked Dependencies"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  },
  {
    "context" : [
      "\"ProjectUITests\" target",
      "Embedded Frameworks"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [

    ],
    "tag" : "dependencies"
  }
]

```
