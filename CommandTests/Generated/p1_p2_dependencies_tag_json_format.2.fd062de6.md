# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "dependencies", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"MismatchingLibrary\" target",
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
      "\"MismatchingLibrary\" target",
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
      "MismatchingLibrary.framework",
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
      {
        "context" : "ProjectFramework.framework Code Sign on Copy",
        "first" : "true",
        "second" : "false"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary.framework",
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
