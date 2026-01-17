import Foundation
import ArgumentParser

/// Disables HealthKit sync.
struct HealthSyncDisableCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "disable",
        abstract: "Disable HealthKit sync (all devices)."
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        try ctx.backend.health.disableSync()
        Logger.info("HealthKit sync: DISABLE requested.")
    }
}
