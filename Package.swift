// swift-tools-version:6.0

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
            targets: ["GCOverseer"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/backslash-f/applogger",
            .upToNextMajor(from: "2.0.0")
        )
    ],
    targets: [
        .target(
            name: "GCOverseer",
            dependencies: [
                .product(
                    name: "AppLogger",
                    package: "applogger"
                )
            ]
        ),
        .testTarget(
            name: "GCOverseerTests",
            dependencies: ["GCOverseer"]
        )
    ],
    swiftLanguageModes: [.v5, .v6]
)
