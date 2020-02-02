# Comparators

The list of built-in comparators available in xcdiff.

### `build_phases`

Compares build phases i.e. dependencies, sources, headers, to ensure all are present in both projects in the same order.

### `configurations`

Compares build configurations i.e. Debug, Release.

### `copy_files`

Compares copy files build phases i.e. embed frameworks, extensions

### `file_references`

Compares all file references in the Xcode project.

As the comparator is very sensitive, it's likely that differences from other comparators will be flagged here too.

### `headers`

Compares headers including their visibility attributes i.e. Public, Project, and Private.

### `linked_dependencies`

Compares linked dependencies

### `resolved_settings` (optional)

Compares evaluated build settings, the final values used by the build system.

As the comparator uses `xcodebuild -showBuildSettings` under the hood, it can be slow depending on the number of targets and configurations being compared. As such it's not included in the default list of comparators.

### `resources`

Compares resources i.e. files copied to the resources directory.

### `settings`

Compares raw project and target level build settings values.

### `sources`

Compares sources including their compiler flag attributes.

### `source_trees`

Compares the project group structure.

### `targets`

Compares target names and types.
