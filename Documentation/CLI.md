# CLI

## Options

### Compare Two Projects

By default xcdiff will try to search your current directory for two projects (in alphabetical order). You can however specify `-p1`, `-p2` paths explicitly.

```sh
xcdiff -p1 <path_to_first_project> -p2 <path_to_second_project>
```

### View a List of All Comparators

`xcdiff` has an option to view all the comparators currently implemented.

```sh
xcdiff -l
```

### Compare Specific Targets

Large projects can have many targets and you may be interested in only a few of them. Use a comma seperated list to specify many targets.

```sh
xcdiff -t "Target1, Target2"
```

###  Compare Specific Configurations

Xcode projects can have a lot of configurations so you can specify a particular configuration to compare.

```sh
xcdiff -c "Beta"
```

### Compare Any Specific Difference Type

xcdiff uses the notion of tags to identify the different types of comparisons it can make. Since you might be interested in looking for a specific type of difference whether it is targets or file references we added the ability to compare by tag.

```sh
xcdiff -l # you can use -l to list all the comparators available
xcdiff -g "targets, configurations"
```

For more information on what each of the comparators does, see [Comparators](Comparators.md).

### Output Format

Since there is a lot of information stored in a `.xcodeproj` file comparisons can get verbose. We provide output format options to make reading the output easier.

There are a few different output formats:
- `console` _(default, if `-f` is not specified)_
- `json`
- `markdown`
- `html`
- `htmlSideBySide` _(diff style format)_

```sh
xcdiff -f markdown # alternatively json or console
```