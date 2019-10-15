# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "source_trees", "-t", "Project", "-f", "markdown", "-v"]
```

# Expected exit code
2

# Expected output
```

## ❌ SOURCE_TREES > Root project

Output format: (<path>, <name>, <source_tree>)

### ⚠️  Only in first (8):

  - `(AViewController.xib, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`
  - `(AnotherObjcClass.h, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`
  - `(AnotherObjcClass.m, nil, <group>) → (Group B, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`
  - `(BarTests.swift, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)`
  - `(LoginTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)`
  - `(empty.png, nil, <group>) → (Screenshots, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)`
  - `(libMismatchingLibrary.a, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)`
  - `(time.png, nil, <group>) → (Resources, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`


### ⚠️  Only in second (11):

  - `(Header4.h, nil, <group>) → (ProjectFramework, nil, <group>) → (nil, nil, <group>)`
  - `(Info.plist, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)`
  - `(ListResponse.json, nil, <group>) → (Responses, nil, <group>) → (ProjectTests, nil, <group>) → (nil, nil, <group>)`
  - `(MetricsTests.swift, nil, <group>) → (ProjectUITests, nil, <group>) → (nil, nil, <group>)`
  - `(MismatchingLibrary-Info.plist, nil, <group>) → (MismatchingLibrary, nil, <group>) → (nil, nil, <group>)`
  - `(MismatchingLibrary.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)`
  - `(NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, <group>) → (nil, nil, <group>)`
  - `(NewFramework.h, nil, <group>) → (NewFramework, nil, <group>) → (nil, nil, <group>)`
  - `(Project.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`
  - `(README.md, nil, <group>) → (nil, nil, <group>)`
  - `(Target.xcconfig, nil, <group>) → (Project, nil, <group>) → (nil, nil, <group>)`




```
