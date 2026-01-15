// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Kokuhaku",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26),
        .watchOS(.v26),
        .macOS(.v26)
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
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			],
			path: "Sources"
        ),
        .testTarget(
			name: "KokuhakuCoreTests",
            dependencies: ["KokuhakuCore"],
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			],
			path: "Tests"
        ),
	]
)
