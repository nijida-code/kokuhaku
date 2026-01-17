import Foundation
import ArgumentParser

/// Selects a catalog entry and stores it locally or marks it for watch/tv.
struct CatalogSelectCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "select",
        abstract: "Select a flow from a catalog and apply it (store/mark)."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Catalog source identifier.
    @Option(name: [.long], help: "Catalog source (e.g., local, github).")
    var source: String = "local"

    /// Catalog entry identifier (implementation-defined).
    @Argument(help: "Catalog entry identifier (implementation-defined).")
    var entry: String

    /// Where to place the selected flow.
    @Option(name: [.long], help: "Target: local, watch, or tv.")
    var target: String = "local"

    mutating func validate() throws {
        let t = target.lowercased()
        if t != "local" && t != "watch" && t != "tv" {
            throw ValidationError("Valid values for --target are: local, watch, tv")
        }
    }

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let fileURL = try ctx.backend.catalog.fetchEntry(source: source, entryID: entry)
        let stored = try ctx.backend.flows.storeFlow(from: fileURL)

        let t = target.lowercased()
        if t == "watch" || t == "tv" {
            let mapped: DeviceTarget = (t == "watch") ? .watch : .tv
            try ctx.backend.flows.markFlow(id: stored.id, target: mapped)
        }

        Logger.info("Selected: \(entry) -> stored as \(stored.id)")
    }
}
