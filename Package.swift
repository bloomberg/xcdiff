// swift-tools-version:5.0
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
    ],
    targets: [
        .target(
            name: "XCDiff",
            dependencies: ["XCDiffCommand"]
        ),
        .target(
            name: "XCDiffCommand",
            dependencies: ["PathKit", "SwiftToolsSupport-auto", "XCDiffCore"]
        ),
        .target(
            name: "XCDiffCore",
            dependencies: ["XcodeProj"]
        ),
        .testTarget(
            name: "XCDiffCommandTests",
            dependencies: ["XCDiffCore", "XCDiffCommand", "PathKit"]
        ),
        .testTarget(
            name: "XCDiffCoreTests",
            dependencies: ["XCDiffCore", "PathKit", "XcodeProj"]
        ),
    ]
)
