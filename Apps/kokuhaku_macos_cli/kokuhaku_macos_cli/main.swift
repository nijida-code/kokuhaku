import Foundation
import ArgumentParser
import KokuhakuCore

// MARK: - Root Command

/// Root command for the Kokuhaku command line interface.
struct KokuhakuCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "kokuhaku",
        abstract: "Kokuhaku command line interface.",
        discussion: "Use subcommands to manage flows, catalogs, iCloud, and Health.",
        version: "0.1.0",
        subcommands: [
            ImportCommand.self,
            ExportCommand.self,
            CreateCommand.self,
            MarkCommand.self,
            StoreCommand.self,
            CatalogCommand.self,
            CloudCommand.self,
            HealthCommand.self
        ]
    )

    // MARK: Global options

    /// Enables verbose output.
    @Flag(name: [.short, .long], help: "Enable verbose logging.")
    var verbose: Bool = false

    /// Suppresses non-error output.
    @Flag(name: [.long], help: "Suppress non-error output.")
    var quiet: Bool = false

    /// Optional directory for app storage (useful for tests and CI).
    @Option(name: [.long], help: "Override the default app storage directory.")
    var storageDir: String?

    /// Optional directory for the local catalog source.
    @Option(name: [.long], help: "Override the local catalog directory.")
    var catalogDir: String?

    mutating func validate() throws {
        if verbose && quiet {
            throw ValidationError("--verbose and --quiet cannot be used together.")
        }
    }

    mutating func run() throws {
        // If invoked without subcommands, print help.
        throw CleanExit.helpRequest(self)
    }
}

// MARK: - Context Builder

extension KokuhakuCLI {
    /// Builds the CLI context shared by subcommands.
    static func makeContext(verbose: Bool, quiet: Bool, storageDir: String?, catalogDir: String?) throws -> CLIContext {
        Logger.isVerbose = verbose
        Logger.isQuiet = quiet

        let storageURL = try resolveStorageDir(override: storageDir)
        let catalogURL = try resolveCatalogDir(override: catalogDir)

        // Early scaffolding backend wiring.
        let backend = DefaultBackend(storageDir: storageURL, localCatalogDir: catalogURL)

        return CLIContext(storageDir: storageURL, localCatalogDir: catalogURL, backend: backend)
    }

    /// Resolves the effective storage directory.
    static func resolveStorageDir(override: String?) throws -> URL {
        if let override {
            return URL(fileURLWithPath: override, isDirectory: true)
        }
        let home = FileManager.default.homeDirectoryForCurrentUser
        return home.appendingPathComponent(".kokuhaku", isDirectory: true)
    }

    /// Resolves the effective local catalog directory.
    static func resolveCatalogDir(override: String?) throws -> URL {
        if let override {
            return URL(fileURLWithPath: override, isDirectory: true)
        }
        let home = FileManager.default.homeDirectoryForCurrentUser
        return home.appendingPathComponent(".kokuhaku-catalog", isDirectory: true)
    }
}

KokuhakuCLI.main()
