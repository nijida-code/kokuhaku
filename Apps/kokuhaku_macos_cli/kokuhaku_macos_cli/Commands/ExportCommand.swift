import Foundation
import ArgumentParser

/// Exports a flow from storage into a file.
struct ExportCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "export",
        abstract: "Export a flow from local storage into a file."
    )

    @OptionGroup var root: KokuhakuCLI

    /// The flow identifier to export.
    @Option(name: [.long], help: "Flow identifier to export.")
    var id: String

    /// Output file path.
    @Option(name: [.short, .long], help: "Output file path.")
    var output: String

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let outURL = URL(fileURLWithPath: output)
        try ctx.backend.flows.exportFlow(id: id, to: outURL)
        Logger.info("Exported \(id) -> \(outURL.path)")
    }
}
