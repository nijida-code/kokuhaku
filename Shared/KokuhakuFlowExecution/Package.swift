// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuFlowExecution",
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
            name: "KokuhakuFlowExecution",
            targets: ["KokuhakuFlowExecution"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore"),
        .package(path: "../KokuhakuNotifications"),
        .package(path: "../KokuhakuAnalytics")
    ],
    targets: [
        .target(
            name: "KokuhakuFlowExecution",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore"),
                .product(name: "KokuhakuNotifications", package: "KokuhakuNotifications"),
                .product(name: "KokuhakuAnalytics", package: "KokuhakuAnalytics")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuFlowExecutionTests",
            dependencies: ["KokuhakuFlowExecution"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        )
    ]
)
