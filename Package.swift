// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcdiff",
    platforms: [
        .macOS(.v10_15),
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
        .package(url: "https://github.com/apple/swift-tools-support-core.git", from: "0.3.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
        .package(url: "https://github.com/tuist/xcodeproj.git", from: "8.15.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
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
