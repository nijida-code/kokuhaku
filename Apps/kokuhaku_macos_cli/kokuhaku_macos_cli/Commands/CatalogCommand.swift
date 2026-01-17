import Foundation
import ArgumentParser

/// Catalog command group (local/github, extendable later).
struct CatalogCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "catalog",
        abstract: "Browse and select flows from catalogs (local or GitHub).",
        subcommands: [CatalogListCommand.self, CatalogSelectCommand.self]
    )

    @OptionGroup var root: KokuhakuCLI

    mutating func run() throws {
        throw CleanExit.helpRequest(self)
    }
}
