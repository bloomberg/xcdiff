#!/bin/bash

# don't pipe on failure
set -o pipefail

# exit on error
trap 'exit' ERR

# create coverage directory
mkdir -p .coverage

# export the coverage output to lcov format
xcrun llvm-cov export -format="lcov" .build/debug/xcdiff -instr-profile .build/debug/codecov/default.profdata > ./.coverage/coverage.lcov

echo "Coverage reports saved to the .coverage directory"
