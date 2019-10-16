# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "\"MismatchingLibrary\" target"
    ],
    "differentValues" : [

    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "MismatchingLibrary\/MismatchingLibrary.h"
    ],
    "tag" : "headers"
  },
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
  },
  {
    "context" : [
      "\"ProjectFramework\" target"
    ],
    "differentValues" : [
      {
        "context" : "ProjectFramework\/Header1.h attributes",
        "first" : "Public",
        "second" : "nil (Project)"
      },
      {
        "context" : "ProjectFramework\/Header2.h attributes",
        "first" : "Private",
        "second" : "nil (Project)"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "ProjectFramework\/Header4.h"
    ],
    "tag" : "headers"
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
    "tag" : "headers"
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
    "tag" : "headers"
  }
]

```
