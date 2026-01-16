// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuAnalytics",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KokuhakuAnalytics",
            targets: ["KokuhakuAnalytics"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore"),
        .package(path: "../KokuhakuHealthKit")
    ],
    targets: [
        .target(
            name: "KokuhakuAnalytics",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore"),
                .product(name: "KokuhakuHealthKit", package: "KokuhakuHealthKit")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuAnalyticsTests",
            dependencies: ["KokuhakuAnalytics"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
