// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuImportGitHub",
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
            name: "KokuhakuImportGitHub",
            targets: ["KokuhakuImportGitHub"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore")
    ],
    targets: [
        .target(
            name: "KokuhakuImportGitHub",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuImportGitHubTests",
            dependencies: ["KokuhakuImportGitHub"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
