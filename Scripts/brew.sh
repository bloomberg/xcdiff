#!/bin/zsh

# don't pipe on failure
set -o pipefail

# exit on error
trap 'exit' ERR

# disable homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# 0.35.0
brew outdated swiftlint || brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c6e596c7d301099a6f1d81c5e9a74a27dea0ade4/Formula/swiftlint.rb

# 0.40.13
brew outdated swiftformat || brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/0e69da465c5f1187521e9fa156639cd48d405f50/Formula/swiftformat.rb
