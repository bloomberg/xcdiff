# Installation

## CLI

### Building from source

1. Clone the repository
```sh
git clone https://github.com/bloomberg/xcdiff.git
cd xcdiff
```

2. Build the project
```sh
swift build -c release
```

The binary will be created in `.build/x86_64-apple-macosx/release/xcdiff`. You can export this path to be able to use the executable from any location in your file system without specifying the full path.

```sh
export PATH="$PATH:$(swift -c release --show-bin-path)"
```

### Homebrew

*TODO*

### Mint

To run xcdiff using [Mint](https://github.com/yonaskolb/Mint):

```sh
mint run bloomberg/xcdiff xcdiff --help
```

To install xcdiff using [Mint](https://github.com/yonaskolb/Mint):

```sh
mint install bloomberg/xcdiff
```

Once installed, you can use xcdiff directly:

```sh
xcdiff --help
```

## Framework

### Swift Package Manager

*TODO*

### CocoaPods

*TODO*

### Carthage

*TODO*