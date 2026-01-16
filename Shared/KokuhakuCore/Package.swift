// swift-tools-version: 6.2
import PackageDescription

let package = Package(
	name: "KokuhakuCore",
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
			name: "KokuhakuCore",
			targets: ["KokuhakuCore"]
		)
	],
	targets: [
		.target(
			name: "KokuhakuCore",
			dependencies: [],
			path: "Sources",
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			]
		),
		.testTarget(
			name: "KokuhakuCoreTests",
			dependencies: ["KokuhakuCore"],
			path: "Tests",
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency")
			]
		),
	]
)
