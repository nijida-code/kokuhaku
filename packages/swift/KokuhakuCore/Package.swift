// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "KokuhakuCore",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10),
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KokuhakuCore",
            targets: ["KokuhakuCore"]
        )
    ],
    targets: [
        .target(
            name: "KokuhakuCore",
            path: "Sources/KokuhakuCore",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
        .testTarget(
            name: "KokuhakuCoreTests",
            dependencies: ["KokuhakuCore"],
            path: "Tests/KokuhakuCoreTests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
