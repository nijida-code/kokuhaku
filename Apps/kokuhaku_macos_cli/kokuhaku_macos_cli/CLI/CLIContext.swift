import Foundation

// MARK: - CLI Context

/// Shared runtime settings and backend services for all CLI commands.
public struct CLIContext: Sendable {
    /// Effective local storage directory (app storage).
    public let storageDir: URL

    /// Optional directory that acts as a local catalog source.
    public let localCatalogDir: URL

    /// Backend service bundle.
    public let backend: Backend

    public init(storageDir: URL, localCatalogDir: URL, backend: Backend) {
        self.storageDir = storageDir
        self.localCatalogDir = localCatalogDir
        self.backend = backend
    }
}

/// A minimal logger used by the CLI.
///
/// Replace this with swift-log later if desired.
public enum Logger {
    public static var isVerbose: Bool = false
    public static var isQuiet: Bool = false

    public static func info(_ message: String) {
        guard !isQuiet else { return }
        print(message)
    }

    public static func verbose(_ message: String) {
        guard isVerbose && !isQuiet else { return }
        print(message)
    }

    public static func error(_ message: String) {
        fputs(message + "\n", stderr)
    }
}
