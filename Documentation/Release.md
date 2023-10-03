# Release Process

1. Bump the version number in [Makefile](../Makefile)
2. Run `make update_version` to update version references in various source and markdown files
3. Make a pull request with the changes
4. Once merged, [draft a new release](https://github.com/bloomberg/xcdiff/releases/new)
5. Tag the release with the appropriate version
6. Use the version number as the release title
7. Populate the description with the recent changes since the last release. For convenience the GitHub built-in **Generate release notes** feature can be used, alternatively the following command can be used to generate a changelog summary:

```bash
git log main...$(git describe --tags `git rev-list --tags --max-count=1`) --pretty=format:'- %s'
```
8. Publish the release
9. Update homebrew formula via locally running `make update_homebrew` _(This publishes a PR to the homebrew core repo)_
