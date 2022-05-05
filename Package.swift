// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcdiff",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .executable(
            name: "xcdiff",
            targets: ["XCDiff"]
        ),
        .library(
            name: "XCDiffCommand",
            targets: ["XCDiffCommand"]
        ),
        .library(
            name: "XCDiffCore",
            targets: ["XCDiffCore"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core.git", .upToNextMajor(from: "0.2.4")),
        .package(url: "https://github.com/kylef/PathKit", .upToNextMinor(from: "1.0.1")),
        .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "8.5.0")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.1.2")),
    ],
    targets: [
        .executableTarget(
            name: "XCDiff",
            dependencies: ["XCDiffCommand"]
        ),
        .target(
            name: "XCDiffCommand",
            dependencies: [
                "PathKit",
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
                "XCDiffCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "XCDiffCore",
            dependencies: [.product(name: "XcodeProj", package: "xcodeproj")]
        ),
        .testTarget(
            name: "XCDiffCommandTests",
            dependencies: [
                "XCDiffCore",
                "XCDiffCommand",
                "PathKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "XCDiffCoreTests",
            dependencies: ["XCDiffCore", "PathKit", .product(name: "XcodeProj", package: "xcodeproj")]
        ),
    ]
)
