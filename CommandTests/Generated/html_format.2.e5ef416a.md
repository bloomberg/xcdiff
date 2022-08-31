# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "html"]
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
        </header><section class="warning"><h2>❌ FILE_REFERENCES</h2></section><section class="warning"><h2>❌ BUILD_PHASES > "MismatchingLibrary" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "Project" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectTests" target</h2></section><section class="success"><h2>✅ BUILD_PHASES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ COPY_FILES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ COPY_FILES > "Project" target > Embed Frameworks</h2></section><section class="success"><h2>✅ COPY_FILES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ COPY_FILES > "ProjectTests" target</h2></section><section class="success"><h2>✅ COPY_FILES > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ TARGETS > NATIVE targets</h2></section><section class="warning"><h2>❌ TARGETS > AGGREGATE targets</h2></section><section class="warning"><h2>❌ HEADERS > "MismatchingLibrary" target</h2></section><section class="success"><h2>✅ HEADERS > "Project" target</h2></section><section class="warning"><h2>❌ HEADERS > "ProjectFramework" target</h2></section><section class="success"><h2>✅ HEADERS > "ProjectTests" target</h2></section><section class="success"><h2>✅ HEADERS > "ProjectUITests" target</h2></section><section class="success"><h2>✅ SOURCES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ SOURCES > "Project" target</h2></section><section class="success"><h2>✅ SOURCES > "ProjectFramework" target</h2></section><section class="warning"><h2>❌ SOURCES > "ProjectTests" target</h2></section><section class="warning"><h2>❌ SOURCES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ RESOURCES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ RESOURCES > "Project" target</h2></section><section class="success"><h2>✅ RESOURCES > "ProjectFramework" target</h2></section><section class="warning"><h2>❌ RESOURCES > "ProjectTests" target</h2></section><section class="warning"><h2>❌ RESOURCES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ RUN_SCRIPTS > "Project" target > "Second script" build phase</h2></section><section class="warning"><h2>❌ RUN_SCRIPTS > "Project" target > "ShellScript" build phase</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectFramework" target</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectTests" target</h2></section><section class="success"><h2>✅ RUN_SCRIPTS > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ CONFIGURATIONS > Root project</h2></section><section class="warning"><h2>❌ SETTINGS > Root project > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > Root project > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > Root project > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > Root project > "Release" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "MismatchingLibrary" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "MismatchingLibrary" target > "Release" configuration > Values</h2></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "Project" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "Project" target > "Release" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectFramework" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectFramework" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectFramework" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectFramework" target > "Release" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Base configuration</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Release" configuration > Base configuration</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectTests" target > "Release" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectUITests" target > "Debug" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectUITests" target > "Debug" configuration > Values</h2></section><section class="success"><h2>✅ SETTINGS > "ProjectUITests" target > "Release" configuration > Base configuration</h2></section><section class="warning"><h2>❌ SETTINGS > "ProjectUITests" target > "Release" configuration > Values</h2></section><section class="warning"><h2>❌ SOURCE_TREES > Root project</h2></section><section class="success"><h2>✅ DEPENDENCIES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ DEPENDENCIES > "Project" target</h2></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectTests" target</h2></section><section class="success"><h2>✅ DEPENDENCIES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ LINKED_DEPENDENCIES > "Project" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectTests" target</h2></section><section class="success"><h2>✅ LINKED_DEPENDENCIES > "ProjectUITests" target</h2></section><section class="warning"><h2>❌ ATTRIBUTES > Root project</h2></section><section class="warning"><h2>❌ ATTRIBUTES > "MismatchingLibrary" target</h2></section><section class="warning"><h2>❌ ATTRIBUTES > "Project" target</h2></section><section class="success"><h2>✅ ATTRIBUTES > "ProjectFramework" target</h2></section><section class="success"><h2>✅ ATTRIBUTES > "ProjectTests" target</h2></section><section class="warning"><h2>❌ ATTRIBUTES > "ProjectUITests" target</h2></section><section class="success"><h2>✅ SWIFT_PACKAGES</h2></section>        <footer>
            Generated by <a href="https://github.com/bloomberg/xcdiff">xcdiff</a>.
        </footer>
    </div>
</body>
</html>

```
