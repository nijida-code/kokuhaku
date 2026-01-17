import Foundation
import ArgumentParser

/// Imports one or more files into the app storage.
struct ImportCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "import",
        abstract: "Import flow files into local storage."
    )

    @OptionGroup var root: KokuhakuCLI

    /// One or more input file paths.
    @Argument(help: "Path(s) to flow file(s) to import.")
    var paths: [String]

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let urls = paths.map { URL(fileURLWithPath: $0) }
        let imported = try ctx.backend.flows.importFiles(urls: urls)

        for flow in imported {
            Logger.info("Imported: \(flow.id)  \(flow.name)")
        }
    }
}
