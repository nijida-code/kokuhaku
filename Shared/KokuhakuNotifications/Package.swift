// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuNotifications",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10),
        .macOS(.v14),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KokuhakuNotifications",
            targets: ["KokuhakuNotifications"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore")
    ],
    targets: [
        .target(
            name: "KokuhakuNotifications",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuNotificationsTests",
            dependencies: ["KokuhakuNotifications"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
