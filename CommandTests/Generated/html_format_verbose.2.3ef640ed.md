# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "html", "-v"]
```

# Expected exit code
2

# Expected output
```
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>xcdiff results</title>
    <meta name="description" content="xcdiff results">
    <meta name="author" content="xcdiff">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        html, body {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            background-color: #fff;
            color: #333;
        }

        footer {
            border-top: 1px #aaa dotted;
            margin-top: 3em;
            color: #aaa;
            font-size: 11px;
            padding-top: 0.4em;
            padding-bottom: 0.4em;
        }

        section {
            margin-top: 1em;
            padding: 0.1em 1em 0.1em 1em;
            border-radius: 0.7em;
        }

        ul {
            margin-top: 0;
            padding-left: 15px;
        }

        li {
            font-family: 'Courier New', Courier, monospace;
        }

        h1 {
            padding: 0.2em 0.5em 0.2em 0.5em;
            font-size: 24px;
            font-weight: 300;
        }

        h2 {
            padding: 0.2em 0.5em 0.2em 0.5em;
            border-radius: 0.2em;
            font-size: 14px;
            font-family: 'Courier New', Courier, monospace;
        }

        h3 {
            font-size: 12px;
            padding-left: 0.2em;
        }

        p {
            margin: 0;
        }

        .container {
            max-width: 1200px;
            padding: 10px;
            margin-right: auto;
            margin-left: auto;
        }

        .warning {
            background-color: #fffce3;
        }

        .warning h2 {
            background-color: #fff2b8;
        }

        .success {
            background-color: #f1ffe9;
        }

        .content {
            padding-left: 2em;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Δ xcdiff result</h1>
        </header><section class="warning"><h2>❌ FILE_REFERENCES</h2><h3>⚠️  Only in first (8):</h3><div class="content"><ul><li>Project/Group B/AViewController.xib</li><li>Project/Group B/AnotherObjcClass.h</li><li>Project/Group B/AnotherObjcClass.m</li><li>Project/Resources/time.png</li><li>ProjectTests/BarTests.swift</li><li>ProjectUITests/LoginTests.swift</li><li>ProjectUITests/Screenshots/empty.png</li><li>libMismatchingLibrary.a</li></ul></div><h3>⚠️  Only in second (11):</h3><div class="content"><ul><li>MismatchingLibrary.framework</li><li>MismatchingLibrary/MismatchingLibrary-Info.plist</li><li>NewFramework.framework</li><li>NewFramework/Info.plist</li><li>NewFramework/NewFramework.h</li><li>Project/Project.xcconfig</li><li>Project/Target.xcconfig</li><li>ProjectFramework/Header4.h</li><li>ProjectTests/Responses/ListResponse.json</li><li>ProjectUITests/MetricsTests.swift</li><li>README.md</li></ul></div></section><section class="warning"><h2>❌ BUILD_PHASES > "MismatchingLibrary" target</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>CopyFiles</li></ul></div><h3>⚠️  Only in second (2):</h3><div class="content"><ul><li>Headers</li><li>Resources</li></ul></div></section><section class="success"><h2>✅ BUILD_PHASES > "Project" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectTests" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ COPY_FILES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ COPY_FILES > "Project" target > Embed Frameworks</h2><h3>⚠️  Only in second (2):</h3><div class="content"><ul><li>MismatchingLibrary.framework</li><li>NewFramework.framework</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>ProjectFramework.framework</p><ul><li>attributes = [&quot;CodeSignOnCopy&quot;, &quot;RemoveHeadersOnCopy&quot;]</li><li>attributes = []</li></ul></li></ul></div></section><section class="success"><h2>✅ COPY_FILES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ COPY_FILES > "ProjectTests" target</h2></section><section class="success"><h2>✅ COPY_FILES > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ TARGETS > NATIVE targets</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>NewFramework</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>MismatchingLibrary product type</p><ul><li>com.apple.product-type.library.static</li><li>com.apple.product-type.framework</li></ul></li></ul></div></section><section class="warning"><h2>❌ TARGETS > AGGREGATE targets</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>NewAggregate</li></ul></div></section><section class="warning"><h2>❌ HEADERS > "MismatchingLibrary" target</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>MismatchingLibrary/MismatchingLibrary.h</li></ul></div></section><section class="success"><h2>✅ HEADERS > "Project" target</h2></section><section class="warning"><h2>❌ HEADERS > "ProjectFramework" target</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>ProjectFramework/Header4.h</li></ul></div><h3>⚠️  Value mismatch (2):</h3><div class="content"><ul><li><p>ProjectFramework/Header1.h attributes</p><ul><li>Public</li><li>nil (Project)</li></ul></li><li><p>ProjectFramework/Header2.h attributes</p><ul><li>Private</li><li>nil (Project)</li></ul></li></ul></div></section><section class="success"><h2>✅ HEADERS > "ProjectTests" target</h2></section><section class="success"><h2>✅ HEADERS > "ProjectUITests" target</h2></section><section class="success"><h2>✅ SOURCES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ SOURCES > "Project" target</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>Project/Group B/AnotherObjcClass.m</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>Project/Group A/ObjcClass.m compiler flags</p><ul><li>nil</li><li>-ObjC</li></ul></li></ul></div></section><section class="success"><h2>✅ SOURCES > "ProjectFramework" target</h2></section><section class="warning"><h2>❌ SOURCES > "ProjectTests" target</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>ProjectTests/BarTests.swift</li></ul></div></section><section class="warning"><h2>❌ SOURCES > "ProjectUITests" target</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>ProjectUITests/LoginTests.swift</li></ul></div><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>ProjectUITests/MetricsTests.swift</li></ul></div></section><section class="success"><h2>✅ RESOURCES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ RESOURCES > "Project" target</h2><h3>⚠️  Only in first (2):</h3><div class="content"><ul><li>Project/Group B/AViewController.xib</li><li>Project/Resources/time.png</li></ul></div></section><section class="success"><h2>✅ RESOURCES > "ProjectFramework" target</h2></section><section class="warning"><h2>❌ RESOURCES > "ProjectTests" target</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>ProjectTests/Responses/ListResponse.json</li></ul></div></section><section class="warning"><h2>❌ RESOURCES > "ProjectUITests" target</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>ProjectUITests/Screenshots/empty.png</li></ul></div></section><section class="success"><h2>✅ RUN_SCRIPTS > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ RUN_SCRIPTS > "Project" target > "Second script" build phase</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>shellScript</p><ul><li>echo &quot;First Hello, world!&quot;
</li><li>echo &quot;second script&quot;
</li></ul></li></ul></div></section><section class="warning"><h2>❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase</h2><h3>⚠️  Value mismatch (2):</h3><div class="content"><ul><li><p>shellScript</p><ul><li>echo &quot;Hello, World!&quot;
</li><li>echo &quot;Hello, world?&quot;
</li></ul></li><li><p>showEnvVarsInLog</p><ul><li>true</li><li>false</li></ul></li></ul></div></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectFramework" target</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectTests" target</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ CONFIGURATIONS > Root project</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>CUSTOM_NEW</li></ul></div></section><section class="warning"><h2>❌ SETTINGS > Root project > "Debug" configuration > Base configuration</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>Path to .xcconfig</p><ul><li>nil</li><li>Project/Project.xcconfig</li></ul></li></ul></div></section><section class="warning"><h2>❌ SETTINGS > Root project > "Debug" configuration > Values</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL</li></ul></div></section><section class="success"><h2>✅ SETTINGS > Root project > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > Root project > "Release" configuration > Values</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL</li></ul></div></section><section class="success"><h2>✅ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>OTHER_LDFLAGS = -ObjC</li></ul></div><h3>⚠️  Only in second (13):</h3><div class="content"><ul><li>CLANG_ENABLE_MODULES = YES</li><li>CURRENT_PROJECT_VERSION = 1</li><li>DEFINES_MODULE = YES</li><li>DYLIB_COMPATIBILITY_VERSION = 1</li><li>DYLIB_CURRENT_VERSION = 1</li><li>DYLIB_INSTALL_NAME_BASE = @rpath</li><li>INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist</li><li>INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks</li><li>LD_RUNPATH_SEARCH_PATHS = [&quot;$(inherited)&quot;, &quot;@executable_path/Frameworks&quot;, &quot;@loader_path/Frameworks&quot;]</li><li>PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary</li><li>SWIFT_OPTIMIZATION_LEVEL = -Onone</li><li>VERSIONING_SYSTEM = apple-generic</li><li>VERSION_INFO_PREFIX = </li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>PRODUCT_NAME</p><ul><li>$(TARGET_NAME)</li><li>$(TARGET_NAME:c99extidentifier)</li></ul></li></ul></div></section><section class="success"><h2>✅ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>OTHER_LDFLAGS = -ObjC</li></ul></div><h3>⚠️  Only in second (12):</h3><div class="content"><ul><li>CLANG_ENABLE_MODULES = YES</li><li>CURRENT_PROJECT_VERSION = 1</li><li>DEFINES_MODULE = YES</li><li>DYLIB_COMPATIBILITY_VERSION = 1</li><li>DYLIB_CURRENT_VERSION = 1</li><li>DYLIB_INSTALL_NAME_BASE = @rpath</li><li>INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist</li><li>INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks</li><li>LD_RUNPATH_SEARCH_PATHS = [&quot;$(inherited)&quot;, &quot;@executable_path/Frameworks&quot;, &quot;@loader_path/Frameworks&quot;]</li><li>PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary</li><li>VERSIONING_SYSTEM = apple-generic</li><li>VERSION_INFO_PREFIX = </li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>PRODUCT_NAME</p><ul><li>$(TARGET_NAME)</li><li>$(TARGET_NAME:c99extidentifier)</li></ul></li></ul></div></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>Path to .xcconfig</p><ul><li>nil</li><li>Project/Target.xcconfig</li></ul></li></ul></div></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Debug" configuration > Values</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>CUSTOM_SETTING_COMMON</p><ul><li>VALUE_1</li><li>VALUE_2</li></ul></li></ul></div></section><section class="success"><h2>✅ SETTINGS > "Project" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Release" configuration > Values</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>CUSTOM_SETTING_COMMON</p><ul><li>VALUE_1</li><li>VALUE_2</li></ul></li></ul></div></section><section class="success"><h2>✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>PRODUCT_BUNDLE_IDENTIFIER</p><ul><li>com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework</li><li>com.bloomberg.xcdiff.Project.ProjectFramework</li></ul></li></ul></div></section><section class="success"><h2>✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectFramework" target > "Release" configuration > Values</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>PRODUCT_BUNDLE_IDENTIFIER</p><ul><li>com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework</li><li>com.bloomberg.xcdiff.Project.ProjectFramework</li></ul></li></ul></div></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>PROVISIONING_PROFILE = </li></ul></div><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>TEST_TARGET_NAME = Project</li></ul></div></section><section class="success"><h2>✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values</h2><h3>⚠️  Only in first (1):</h3><div class="content"><ul><li>PROVISIONING_PROFILE = </li></ul></div><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>TEST_TARGET_NAME = Project</li></ul></div></section><section class="warning"><h2>❌ SOURCE_TREES > Root project</h2><p>Output format: (&#x3C;path&#x3E;, &#x3C;name&#x3E;, &#x3C;source_tree&#x3E;)</p><h3>⚠️  Only in first (8):</h3><div class="content"><ul><li>(AViewController.xib, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(AnotherObjcClass.h, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(AnotherObjcClass.m, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(BarTests.swift, nil, &#x3C;group&#x3E;) → (ProjectTests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(LoginTests.swift, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(empty.png, nil, &#x3C;group&#x3E;) → (Screenshots, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(libMismatchingLibrary.a, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(time.png, nil, &#x3C;group&#x3E;) → (Resources, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li></ul></div><h3>⚠️  Only in second (11):</h3><div class="content"><ul><li>(Header4.h, nil, &#x3C;group&#x3E;) → (ProjectFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(Info.plist, nil, &#x3C;group&#x3E;) → (NewFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(ListResponse.json, nil, &#x3C;group&#x3E;) → (Responses, nil, &#x3C;group&#x3E;) → (ProjectTests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(MetricsTests.swift, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(MismatchingLibrary-Info.plist, nil, &#x3C;group&#x3E;) → (MismatchingLibrary, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(MismatchingLibrary.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(NewFramework.h, nil, &#x3C;group&#x3E;) → (NewFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(Project.xcconfig, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(README.md, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li><li>(Target.xcconfig, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)</li></ul></div></section><section class="success"><h2>✅ DEPENDENCIES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ DEPENDENCIES > "Project" target</h2><h3>⚠️  Only in second (2):</h3><div class="content"><ul><li>(target=MismatchingLibrary)</li><li>(target=NewFramework)</li></ul></div></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectTests" target</h2></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ LINKED_DEPENDENCIES > "Project" target</h2><h3>⚠️  Only in second (2):</h3><div class="content"><ul><li>MismatchingLibrary.framework</li><li>NewFramework.framework</li></ul></div><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>ARKit.framework attributes</p><ul><li>required</li><li>optional</li></ul></li></ul></div></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectTests" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ ATTRIBUTES > Root project</h2><h3>⚠️  Value mismatch (3):</h3><div class="content"><ul><li><p>LastSwiftUpdateCheck</p><ul><li>1110</li><li>1030</li></ul></li><li><p>LastUpgradeCheck</p><ul><li>1020</li><li>1030</li></ul></li><li><p>ORGANIZATIONNAME</p><ul><li>Bloomberg LP</li><li>Another Organization</li></ul></li></ul></div></section><section class="warning"><h2>❌ ATTRIBUTES > "MismatchingLibrary" target</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>LastSwiftMigration = 1110</li></ul></div></section><section class="warning"><h2>❌ ATTRIBUTES > "Project" target</h2><h3>⚠️  Value mismatch (1):</h3><div class="content"><ul><li><p>LastSwiftMigration</p><ul><li>1140</li><li>1020</li></ul></li></ul></div></section><section class="success"><h2>✅ ATTRIBUTES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ ATTRIBUTES > "ProjectTests" target</h2></section><section class="warning"><h2>❌ ATTRIBUTES > "ProjectUITests" target</h2><h3>⚠️  Only in second (1):</h3><div class="content"><ul><li>TestTargetID = Project</li></ul></div></section><section class="success"><h2>✅ SWIFT_PACKAGES</h2></section>        <footer>
            Generated by <a href="https://github.com/bloomberg/xcdiff">xcdiff</a>.
        </footer>
    </div>
</body>
</html>

```
