import Foundation
import ArgumentParser

/// Toggles HealthKit sync for all devices on the same Apple ID (conceptually).
struct HealthSyncCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "sync",
        abstract: "Enable or disable HealthKit sync.",
        subcommands: [HealthSyncEnableCommand.self, HealthSyncDisableCommand.self]
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        throw CleanExit.helpRequest(self)
    }
}
