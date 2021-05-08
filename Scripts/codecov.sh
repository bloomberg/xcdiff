#!/usr/bin/env bash
set -eu

GIT_COMMIT=1b4b96ac38946b20043b3ca3bad88d95462259b6
SHA256SUM="d6aa3207c4908d123bd8af62ec0538e3f2b9f257c3de62fad4e29cd3b59b41d9  codecov"
SHA512SUM="b6492196dd844cd81a688536bb42463d28bd666448335c4a8fc7f8f9b9b9afc346a467e3401e3fc49e6047442a30d93a4adfaa1590101224a186013c6179c48d  codecov"

INITIAL_DIR=$(pwd)

curl -s "https://raw.githubusercontent.com/codecov/codecov-bash/${GIT_COMMIT}/codecov" > codecov

function tearDown {
  cd ${INITIAL_DIR}
  rm codecov
}
trap tearDown EXIT

VERSION=$(grep 'VERSION=\"[0-9\.]*\"' codecov | cut -d'"' -f2)
echo "Verifying codecov ${VERSION}"

shasum -a 256 codecov
shasum -a 256 -c <(echo "${SHA256SUM}")

shasum -a 512 codecov
shasum -a 512 -c <(echo "${SHA512SUM}")

bash codecov -D .coverage
