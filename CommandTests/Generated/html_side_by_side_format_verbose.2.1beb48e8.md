# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "htmlSideBySide", "-v"]
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

        .firstColumn {
            width: 50%;
        }

        .secondColumn {
            width: 50%;
        }

        .onlyFirstContent td:nth-child(1) {
            background-color: #ffdfe6;
        }

        .onlyFirstContent td:nth-child(2) {
            background-color: #efefef;
        }

        .onlySecondContent td:nth-child(1) {
            background-color: #efefef;
        }

        .onlySecondContent td:nth-child(2) {
            background-color: #e3f8d7;
        }

        .differentContentKey {
            background-color: #f4efbc;
            color: #56494E;
            font-weight: bold;
        }

        .differentContent {
            background-color: #f9f5cb;
        }

        .differentContent td {
            padding: 2pt 15pt;
        }

        .rowHeading {
            text-align: center;
            font-weight: bold;
        }

        .rowSpacer {
            height: 10pt;
        }

        table {
            width: 100%;
        }

        table td {
            width: 50%;
            padding: 2pt 5pt;
        }

    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Δ xcdiff result</h1>
        </header>
        <div class="content">
            <section class="warning">
    <h2>❌ FILE_REFERENCES</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            Project/Group B/AViewController.xib
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            Project/Group B/AnotherObjcClass.h
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            Project/Group B/AnotherObjcClass.m
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            Project/Resources/time.png
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            ProjectTests/BarTests.swift
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            ProjectUITests/LoginTests.swift
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            ProjectUITests/Screenshots/empty.png
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            libMismatchingLibrary.a
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            MismatchingLibrary.framework
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            MismatchingLibrary/MismatchingLibrary-Info.plist
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework.framework
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework/Info.plist
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework/NewFramework.h
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            Project/Project.xcconfig
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            Project/Target.xcconfig
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectFramework/Header4.h
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectTests/Responses/ListResponse.json
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectUITests/MetricsTests.swift
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            README.md
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ BUILD_PHASES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            CopyFiles
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            Headers
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            Resources
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ BUILD_PHASES &#x3E; &quot;Project&quot; target</h2>
</section>
<section class="success">
    <h2>✅ BUILD_PHASES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ BUILD_PHASES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ BUILD_PHASES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ COPY_FILES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ COPY_FILES &#x3E; &quot;Project&quot; target &#x3E; Embed Frameworks</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            MismatchingLibrary.framework
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework.framework
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            ProjectFramework.framework
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            attributes = [&quot;CodeSignOnCopy&quot;, &quot;RemoveHeadersOnCopy&quot;]
        </td>
        <td>
            attributes = []
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ COPY_FILES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ COPY_FILES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ COPY_FILES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ TARGETS &#x3E; NATIVE targets</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            MismatchingLibrary product type
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            com.apple.product-type.library.static
        </td>
        <td>
            com.apple.product-type.framework
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ TARGETS &#x3E; AGGREGATE targets</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewAggregate
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ HEADERS &#x3E; &quot;MismatchingLibrary&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            MismatchingLibrary/MismatchingLibrary.h
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ HEADERS &#x3E; &quot;Project&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ HEADERS &#x3E; &quot;ProjectFramework&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectFramework/Header4.h
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            ProjectFramework/Header1.h attributes
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            Public
        </td>
        <td>
            nil (Project)
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            ProjectFramework/Header2.h attributes
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            Private
        </td>
        <td>
            nil (Project)
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ HEADERS &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ HEADERS &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ SOURCES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ SOURCES &#x3E; &quot;Project&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            Project/Group B/AnotherObjcClass.m
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            Project/Group A/ObjcClass.m compiler flags
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            nil
        </td>
        <td>
            -ObjC
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SOURCES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ SOURCES &#x3E; &quot;ProjectTests&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            ProjectTests/BarTests.swift
        </td>
        <td>
            
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SOURCES &#x3E; &quot;ProjectUITests&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            ProjectUITests/LoginTests.swift
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectUITests/MetricsTests.swift
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ RESOURCES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;Project&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            Project/Group B/AViewController.xib
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            Project/Resources/time.png
        </td>
        <td>
            
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ RESOURCES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;ProjectTests&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ProjectTests/Responses/ListResponse.json
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;ProjectUITests&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            ProjectUITests/Screenshots/empty.png
        </td>
        <td>
            
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ RUN_SCRIPTS &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RUN_SCRIPTS &#x3E; &quot;Project&quot; target &#x3E; &quot;Second script&quot; build phase</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            shellScript
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            echo &quot;First Hello, world!&quot;

        </td>
        <td>
            echo &quot;second script&quot;

        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ RUN_SCRIPTS &#x3E; &quot;Project&quot; target &#x3E; &quot;ShellScript&quot; build phase</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            shellScript
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            echo &quot;Hello, World!&quot;

        </td>
        <td>
            echo &quot;Hello, world?&quot;

        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            showEnvVarsInLog
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            true
        </td>
        <td>
            false
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ RUN_SCRIPTS &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ RUN_SCRIPTS &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ RUN_SCRIPTS &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ CONFIGURATIONS &#x3E; Root project</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CUSTOM_NEW
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            Path to .xcconfig
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            nil
        </td>
        <td>
            Project/Project.xcconfig
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; Root project &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CUSTOM_SETTGING_1 = CS_1_PROJECT_LEVEL
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            OTHER_LDFLAGS = -ObjC
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CLANG_ENABLE_MODULES = YES
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CURRENT_PROJECT_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DEFINES_MODULE = YES
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_COMPATIBILITY_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_CURRENT_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_INSTALL_NAME_BASE = @rpath
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            LD_RUNPATH_SEARCH_PATHS = [&quot;$(inherited)&quot;, &quot;@executable_path/Frameworks&quot;, &quot;@loader_path/Frameworks&quot;]
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            SWIFT_OPTIMIZATION_LEVEL = -Onone
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            VERSIONING_SYSTEM = apple-generic
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            VERSION_INFO_PREFIX = 
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            PRODUCT_NAME
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            $(TARGET_NAME)
        </td>
        <td>
            $(TARGET_NAME:c99extidentifier)
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            OTHER_LDFLAGS = -ObjC
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CLANG_ENABLE_MODULES = YES
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            CURRENT_PROJECT_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DEFINES_MODULE = YES
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_COMPATIBILITY_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_CURRENT_VERSION = 1
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            DYLIB_INSTALL_NAME_BASE = @rpath
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            INFOPLIST_FILE = MismatchingLibrary/MismatchingLibrary-Info.plist
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            INSTALL_PATH = $(LOCAL_LIBRARY_DIR)/Frameworks
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            LD_RUNPATH_SEARCH_PATHS = [&quot;$(inherited)&quot;, &quot;@executable_path/Frameworks&quot;, &quot;@loader_path/Frameworks&quot;]
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            PRODUCT_BUNDLE_IDENTIFIER = com.bloomberg.xcdiff.Project.MismatchingLibrary
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            VERSIONING_SYSTEM = apple-generic
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            VERSION_INFO_PREFIX = 
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            PRODUCT_NAME
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            $(TARGET_NAME)
        </td>
        <td>
            $(TARGET_NAME:c99extidentifier)
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            Path to .xcconfig
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            nil
        </td>
        <td>
            Project/Target.xcconfig
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            CUSTOM_SETTING_COMMON
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            VALUE_1
        </td>
        <td>
            VALUE_2
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            CUSTOM_SETTING_COMMON
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            VALUE_1
        </td>
        <td>
            VALUE_2
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            PRODUCT_BUNDLE_IDENTIFIER
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework
        </td>
        <td>
            com.bloomberg.xcdiff.Project.ProjectFramework
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            PRODUCT_BUNDLE_IDENTIFIER
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            com.bloomberg.xcdiff.Project.testprovisioning.ProjectFramework
        </td>
        <td>
            com.bloomberg.xcdiff.Project.ProjectFramework
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectTests&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectTests&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectTests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectTests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            PROVISIONING_PROFILE = 
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            TEST_TARGET_NAME = Project
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            PROVISIONING_PROFILE = 
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            TEST_TARGET_NAME = Project
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ SOURCE_TREES &#x3E; Root project</h2>
<p>
    Output format: (&#x3C;path&#x3E;, &#x3C;name&#x3E;, &#x3C;source_tree&#x3E;)
</p>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlyFirstContent">
        <td>
            (AViewController.xib, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (AnotherObjcClass.h, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (AnotherObjcClass.m, nil, &#x3C;group&#x3E;) → (Group B, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (BarTests.swift, nil, &#x3C;group&#x3E;) → (ProjectTests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (LoginTests.swift, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (empty.png, nil, &#x3C;group&#x3E;) → (Screenshots, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (libMismatchingLibrary.a, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlyFirstContent">
        <td>
            (time.png, nil, &#x3C;group&#x3E;) → (Resources, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
        <td>
            
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (Header4.h, nil, &#x3C;group&#x3E;) → (ProjectFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (Info.plist, nil, &#x3C;group&#x3E;) → (NewFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (ListResponse.json, nil, &#x3C;group&#x3E;) → (Responses, nil, &#x3C;group&#x3E;) → (ProjectTests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (MetricsTests.swift, nil, &#x3C;group&#x3E;) → (ProjectUITests, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (MismatchingLibrary-Info.plist, nil, &#x3C;group&#x3E;) → (MismatchingLibrary, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (MismatchingLibrary.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (NewFramework.framework, nil, BUILT_PRODUCTS_DIR) → (nil, Products, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (NewFramework.h, nil, &#x3C;group&#x3E;) → (NewFramework, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (Project.xcconfig, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (README.md, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (Target.xcconfig, nil, &#x3C;group&#x3E;) → (Project, nil, &#x3C;group&#x3E;) → (nil, nil, &#x3C;group&#x3E;)
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ DEPENDENCIES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ DEPENDENCIES &#x3E; &quot;Project&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (target=MismatchingLibrary)
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            (target=NewFramework)
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ DEPENDENCIES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ DEPENDENCIES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ DEPENDENCIES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ LINKED_DEPENDENCIES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ LINKED_DEPENDENCIES &#x3E; &quot;Project&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            MismatchingLibrary.framework
        </td>
    </tr>
    <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            NewFramework.framework
        </td>
    </tr>
    <tr class="rowSpacer">
        <td colspan="2">
            
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            ARKit.framework attributes
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            required
        </td>
        <td>
            optional
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ LINKED_DEPENDENCIES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ LINKED_DEPENDENCIES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ LINKED_DEPENDENCIES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; Root project</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            LastSwiftUpdateCheck
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            1110
        </td>
        <td>
            1030
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            LastUpgradeCheck
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            1020
        </td>
        <td>
            1030
        </td>
    </tr>
    <tr class="differentContentKey">
        <td colspan="2">
            ORGANIZATIONNAME
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            Bloomberg LP
        </td>
        <td>
            Another Organization
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            LastSwiftMigration = 1110
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;Project&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="differentContentKey">
        <td colspan="2">
            LastSwiftMigration
        </td>
    </tr>
    <tr class="differentContent">
        <td>
            1140
        </td>
        <td>
            1020
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ ATTRIBUTES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ ATTRIBUTES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;ProjectUITests&quot; target</h2>
<table>
    <thead>
        <tr>
            <th>First</th>
            <th>Second</th>
        </tr>
    </thead>
    <tbody>
            <tr class="onlySecondContent">
        <td>
            
        </td>
        <td>
            TestTargetID = Project
        </td>
    </tr>
    </tbody>
</table>
</section>
<section class="success">
    <h2>✅ SWIFT_PACKAGES</h2>
</section>
        </div>
        <footer>
            Generated by <a href="https://github.com/bloomberg/xcdiff">xcdiff</a>.
        </footer>
    </div>
</body>
</html>

```
