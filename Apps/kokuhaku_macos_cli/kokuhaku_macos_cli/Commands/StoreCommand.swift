import Foundation
import ArgumentParser

/// Stores a flow into the app storage (explicit command, useful for piping workflows).
struct StoreCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "store",
        abstract: "Store a flow into the app storage."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Input file that contains a flow JSON.
    @Option(name: [.short, .long], help: "Input JSON file.")
    var input: String

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let url = URL(fileURLWithPath: input)
        let flow = try ctx.backend.flows.storeFlow(from: url)
        Logger.info("Stored: \(flow.id)  \(flow.name)")
    }
}
