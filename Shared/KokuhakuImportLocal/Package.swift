// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuImportLocal",
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
            name: "KokuhakuImportLocal",
            targets: ["KokuhakuImportLocal"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore")
    ],
    targets: [
        .target(
            name: "KokuhakuImportLocal",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuImportLocalTests",
            dependencies: ["KokuhakuImportLocal"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
