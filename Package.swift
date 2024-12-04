// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "GCOverseer",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18)
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
        ),

        .package(
            url: "https://github.com/apple/swift-testing.git",
            branch: "swift-6.0.2-RELEASE"
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
            dependencies: [
                "GCOverseer",
                .product(
                    name: "Testing",
                    package: "swift-testing"
                )
            ]
        )
    ],
    swiftLanguageModes: [.v5, .v6]
)
