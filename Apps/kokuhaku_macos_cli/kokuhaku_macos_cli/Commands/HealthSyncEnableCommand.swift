import Foundation
import ArgumentParser

/// Enables HealthKit sync.
struct HealthSyncEnableCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "enable",
        abstract: "Enable HealthKit sync (all devices)."
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        try ctx.backend.health.enableSync()
        Logger.info("HealthKit sync: ENABLE requested.")
    }
}
