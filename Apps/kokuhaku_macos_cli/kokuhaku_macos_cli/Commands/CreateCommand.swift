import Foundation
import ArgumentParser

/// Creates a new flow (initially stored locally).
struct CreateCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "create",
        abstract: "Create a new flow and store it locally."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Optional title for the new flow.
    @Option(name: [.long], help: "Human-readable name for the flow.")
    var name: String?

    /// Optional input file (template) to seed the new flow.
    @Option(name: [.long], help: "Optional JSON template file.")
    var template: String?

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let templateURL = template.map { URL(fileURLWithPath: $0) }
        let flow = try ctx.backend.flows.createFlow(name: name, templateURL: templateURL)
        Logger.info("Created: \(flow.id)  \(flow.name)")
    }
}
