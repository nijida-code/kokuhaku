import Foundation
import ArgumentParser

/// Cloud command group (CloudKit backing expected).
struct CloudCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "cloud",
        abstract: "Cloud operations (CloudKit).",
        subcommands: [CloudSaveCommand.self]
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        throw CleanExit.helpRequest(self)
    }
}
