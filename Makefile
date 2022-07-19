VERSION_MAJOR = 0
VERSION_MINOR = 9
VERSION_PATCH = 0
VERSION = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)
GIT_SHORT_HASH = $(shell git rev-parse --short HEAD)

TOOL_NAME = xcdiff
PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/
BUILD_PATH = .build/apple/Products/Release/$(TOOL_NAME)

clean:
	xcrun swift package clean

install: clean build
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	xcrun swift build --disable-sandbox -c release --arch arm64 --arch x86_64

test:
	xcrun swift test --enable-code-coverage

test_ci: test
	./Scripts/coverage.sh

update_version:
	sed -i '' 's/\(Version(\)\(.*\)\(, \)/\1$(VERSION_MAJOR), $(VERSION_MINOR), $(VERSION_PATCH)\3/' Sources/XCDiffCommand/Constants.swift
	sed -i '' 's/upToNextMinor(from: ".*")/upToNextMinor(from: "${VERSION}")/' Documentation/Installation.md
	sed -i '' 's/output, ".*debug.local/output, "${VERSION}+debug.local/' Tests/XCDiffCommandTests/CommandsRunnerTests.swift

update_hash:
	sed -i '' 's/#GIT_SHORT_HASH#/$(GIT_SHORT_HASH)/' Sources/XCDiffCommand/Constants.swift

format:
	swiftformat .

autocorrect:
	swiftlint autocorrect --quiet

lint:
	swiftlint version
	swiftformat --version
	swiftlint --strict --quiet
	swiftformat . --lint

regenerate_command_snapshots:
	./Scripts/generate_tests_commands_files.py

install_tools:
	./Scripts/brew.sh

