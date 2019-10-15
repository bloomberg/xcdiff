# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "targets", "-v"]
```

# Expected exit code
2

# Expected output
```
❌ TARGETS > NATIVE targets

⚠️  Only in second (1):

  • NewFramework


⚠️  Value mismatch (1):

  • MismatchingLibrary product type
    ◦ com.apple.product-type.library.static
    ◦ com.apple.product-type.framework


❌ TARGETS > AGGREGATE targets

⚠️  Only in second (1):

  • NewAggregate




```
