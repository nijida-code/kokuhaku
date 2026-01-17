import Foundation
import ArgumentParser

/// Health command group (reporting and sync toggle).
struct HealthCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "health",
        abstract: "Health evaluation and HealthKit sync controls.",
        subcommands: [HealthReportCommand.self, HealthSyncCommand.self]
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        throw CleanExit.helpRequest(self)
    }
}
