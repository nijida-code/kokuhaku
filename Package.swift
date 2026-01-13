// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Kokuhaku",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10),
        .macOS(.v14)
    ],
    products: [
        // Libraries
        .library(
            name: "KokuhakuCore",
            targets: ["KokuhakuCore"]
        )
    ],
    targets: [
        // MARK: - Core
        .target(
            name: "KokuhakuCore",
            dependencies: [],
            path: "Sources/KokuhakuCore"
        ),
        .testTarget(
            name: "KokuhakuCoreTests",
            dependencies: ["KokuhakuCore"],
            path: "Tests/KokuhakuCoreTests"
        ),
	]
)
