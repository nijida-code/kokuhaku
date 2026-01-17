import Foundation
import ArgumentParser

/// Saves a flow to iCloud (CloudKit).
struct CloudSaveCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "save",
        abstract: "Save a locally stored flow into iCloud (CloudKit)."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Flow identifier to save.
    @Option(name: [.long], help: "Flow identifier to save.")
    var id: String

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let flow = try ctx.backend.flows.loadFlow(id: id)
        try ctx.backend.cloud.saveToCloud(flow: flow)
        Logger.info("Cloud save requested for: \(flow.id)")
    }
}
