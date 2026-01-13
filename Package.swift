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
        ),
        //.library(
        //    name: "KokuhakuStorageICloud",
        //    targets: ["KokuhakuStorageICloud"]
        //),
        //.library(
        //    name: "KokuhakuWatchLink",
        //    targets: ["KokuhakuWatchLink"]
        //),
        
        // CLI executable
        .executable(
            name: "kokuhaku",
            targets: ["KokuhakuCLI"]
        )
    ],
    dependencies: [
        // Für CLI-Argumente
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.3.0"
        ),
        .package(
            url: "https://github.com/gonzalezreal/DefaultCodable",
            from: "1.0.0"
        )
    ],
    targets: [
        // MARK: - Core (pure domain, überall nutzbar)
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
        
        // MARK: - iCloud Storage (iOS + macOS)
        //.target(
        //    name: "KokuhakuStorageICloud",
        //    dependencies: ["KokuhakuCore"],
        //    path: "Sources/KokuhakuStorageICloud",
        //    swiftSettings: [
        //        .define("KOKUHAKU_ICLOUD")
        //    ]
        //),
        //.testTarget(
        //    name: "KokuhakuStorageICloudTests",
        //    dependencies: ["KokuhakuStorageICloud"],
        //    path: "Tests/KokuhakuStorageICloudTests"
        //),
        
        // MARK: - Watch Link (iOS + watchOS) – Platzhalter, wenn du es noch nicht hast
        //.target(
        //    name: "KokuhakuWatchLink",
        //    dependencies: ["KokuhakuCore"],
        //    path: "Sources/KokuhakuWatchLink"
        //),
        
        // MARK: - CLI Executable
        .executableTarget(
            name: "KokuhakuCLI",
            dependencies: [
                "KokuhakuCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/KokuhakuCLI"
        ),
        .testTarget(
            name: "KokuhakuCLITests",
            dependencies: ["KokuhakuCore"],
			path: "Tests/KokuhakuCLITests"
		)
	]
)
