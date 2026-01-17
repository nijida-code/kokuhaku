import Foundation
import ArgumentParser

/// Lists available catalog entries.
struct CatalogListCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List flows from a catalog source."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Catalog source identifier.
    @Option(name: [.long], help: "Catalog source (e.g., local, github).")
    var source: String = "local"

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let entries = try ctx.backend.catalog.list(source: source)
        if entries.isEmpty {
            Logger.info("No entries found.")
            return
        }

        for e in entries {
            Logger.info("\(e.entryID)  \(e.title)")
        }
    }
}
