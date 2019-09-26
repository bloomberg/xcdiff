# CLI

## Options

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
xcdiff -l # you can use -l to find all the comparators available
xcdiff -g "targets, configurations"
```

### Output Format

Since there is a lot of information stored in a `.xcodeproj` file comparisons can get verbose. We provide output format options to make reading the output easier.

There are three output formats:
- `console` (default, if `-f` is not specified)
- `json`
- `markdown`

```sh
xcdiff -f markdown # alternatively json or console
```