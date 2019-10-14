#!/bin/zsh

# don't pipe on failure
set -o pipefail

# exit on error
trap 'exit' ERR

# run swiftlint
swiftlint version
swiftlint --strict --quiet

# run swiftformat
swiftformat --version
swiftformat . --lint
