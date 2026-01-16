// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "KokuhakuFlowCatalog",
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
            name: "KokuhakuFlowCatalog",
            targets: ["KokuhakuFlowCatalog"]
        )
    ],
    dependencies: [
        .package(path: "../KokuhakuCore"),
        .package(path: "../KokuhakuImportLocal"),
        .package(path: "../KokuhakuImportGitHub"),
        .package(path: "../KokuhakuImportGit")
    ],
    targets: [
        .target(
            name: "KokuhakuFlowCatalog",
            dependencies: [
                .product(name: "KokuhakuCore", package: "KokuhakuCore"),
                .product(name: "KokuhakuImportLocal", package: "KokuhakuImportLocal"),
                .product(name: "KokuhakuImportGitHub", package: "KokuhakuImportGitHub"),
                .product(name: "KokuhakuImportGit", package: "KokuhakuImportGit")
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "KokuhakuFlowCatalogTests",
            dependencies: ["KokuhakuFlowCatalog"],
            path: "Tests",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
    ]
)
