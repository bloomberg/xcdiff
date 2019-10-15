# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "targets", "-f", "json"]
```

# Expected exit code
2

# Expected output
```
[
  {
    "context" : [
      "NATIVE targets"
    ],
    "differentValues" : [
      {
        "context" : "MismatchingLibrary product type",
        "first" : "com.apple.product-type.library.static",
        "second" : "com.apple.product-type.framework"
      }
    ],
    "onlyInFirst" : [

    ],
    "onlyInSecond" : [
      "NewFramework"
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
      "NewAggregate"
    ],
    "tag" : "targets"
  }
]

```
