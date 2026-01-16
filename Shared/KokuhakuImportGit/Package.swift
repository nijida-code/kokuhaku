// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuImportGit",
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
            name: "KokuhakuImportGit",
            targets: ["KokuhakuImportGit"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore")
    ],
    targets: [
        .target(
            name: "KokuhakuImportGit",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuImportGitTests",
            dependencies: ["KokuhakuImportGit"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
