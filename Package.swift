// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GCOverseer",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "GCOverseer",
            targets: ["GCOverseer"]),
    ],
    dependencies: [
        .package(name: "AppLogger", url: "https://github.com/backslash-f/applogger", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "GCOverseer",
            dependencies: ["AppLogger"]),
        .testTarget(
            name: "GCOverseerTests",
            dependencies: ["GCOverseer"]),
    ],
    swiftLanguageVersions: [.v5]
)
