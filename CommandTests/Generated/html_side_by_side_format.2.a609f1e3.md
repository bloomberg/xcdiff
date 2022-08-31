# Command
```json
["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-f", "htmlSideBySide"]
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
</section>
<section class="warning">
    <h2>❌ BUILD_PHASES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
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
</section>
<section class="warning">
    <h2>❌ TARGETS &#x3E; AGGREGATE targets</h2>
</section>
<section class="warning">
    <h2>❌ HEADERS &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="success">
    <h2>✅ HEADERS &#x3E; &quot;Project&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ HEADERS &#x3E; &quot;ProjectFramework&quot; target</h2>
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
</section>
<section class="success">
    <h2>✅ SOURCES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ SOURCES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ SOURCES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ RESOURCES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;Project&quot; target</h2>
</section>
<section class="success">
    <h2>✅ RESOURCES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RESOURCES &#x3E; &quot;ProjectUITests&quot; target</h2>
</section>
<section class="success">
    <h2>✅ RUN_SCRIPTS &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ RUN_SCRIPTS &#x3E; &quot;Project&quot; target &#x3E; &quot;Second script&quot; build phase</h2>
</section>
<section class="warning">
    <h2>❌ RUN_SCRIPTS &#x3E; &quot;Project&quot; target &#x3E; &quot;ShellScript&quot; build phase</h2>
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
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; Root project &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; Root project &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;MismatchingLibrary&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;Project&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Debug&quot; configuration &#x3E; Values</h2>
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectFramework&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
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
</section>
<section class="success">
    <h2>✅ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Base configuration</h2>
</section>
<section class="warning">
    <h2>❌ SETTINGS &#x3E; &quot;ProjectUITests&quot; target &#x3E; &quot;Release&quot; configuration &#x3E; Values</h2>
</section>
<section class="warning">
    <h2>❌ SOURCE_TREES &#x3E; Root project</h2>
</section>
<section class="success">
    <h2>✅ DEPENDENCIES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ DEPENDENCIES &#x3E; &quot;Project&quot; target</h2>
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
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;MismatchingLibrary&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;Project&quot; target</h2>
</section>
<section class="success">
    <h2>✅ ATTRIBUTES &#x3E; &quot;ProjectFramework&quot; target</h2>
</section>
<section class="success">
    <h2>✅ ATTRIBUTES &#x3E; &quot;ProjectTests&quot; target</h2>
</section>
<section class="warning">
    <h2>❌ ATTRIBUTES &#x3E; &quot;ProjectUITests&quot; target</h2>
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
