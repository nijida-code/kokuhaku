// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "kokuhaku-cli",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "kokuhaku", targets: ["kokuhaku"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.5.0"),
        .package(path: "../../../packages/swift/KokuhakuCore")
    ],
    targets: [
        .executableTarget(
            name: "kokuhaku",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "KokuhakuCore"
            ],
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .enableUpcomingFeature("ExistentialAny")
            ]
        )
    ]
)
