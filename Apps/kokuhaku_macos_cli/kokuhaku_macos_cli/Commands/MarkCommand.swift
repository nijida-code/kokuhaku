import Foundation
import ArgumentParser

/// Marks an existing flow for a device target (watch/tv).
struct MarkCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "mark",
        abstract: "Mark a flow for Watch or tvOS."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Flow identifier to mark.
    @Option(name: [.long], help: "Flow identifier to mark.")
    var id: String

    /// Device target to mark the flow for.
    @Option(name: [.long], help: "Target device: watch or tv.")
    var target: String

    mutating func validate() throws {
        let t = target.lowercased()
        if t != "watch" && t != "tv" {
            throw ValidationError("Valid values for --target are: watch, tv")
        }
    }

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let mapped: DeviceTarget = (target.lowercased() == "watch") ? .watch : .tv
        try ctx.backend.flows.markFlow(id: id, target: mapped)
        Logger.info("Marked: \(id) -> \(mapped.rawValue)")
    }
}
