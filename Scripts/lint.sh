#!/bin/zsh

# don't pipe on failure
set -o pipefail

# exit on error
trap 'exit' ERR

# Print versions
echo "SwiftLint version"
swiftlint version

echo "SwiftFormat version"
swiftformat --version

# run swiftlint
swiftlint --strict --quiet

# run swiftformat
swiftformat . --lint
