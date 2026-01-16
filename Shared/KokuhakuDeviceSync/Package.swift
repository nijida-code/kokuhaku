// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuDeviceSync",
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
            name: "KokuhakuDeviceSync",
            targets: ["KokuhakuDeviceSync"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore")
    ],
    targets: [
        .target(
            name: "KokuhakuDeviceSync",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuDeviceSyncTests",
            dependencies: ["KokuhakuDeviceSync"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
