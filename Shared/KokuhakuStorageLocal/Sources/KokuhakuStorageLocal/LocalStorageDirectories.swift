import Foundation

/// Provides filesystem locations used by Kokuhaku local storage.
///
/// This type avoids UI dependencies and is safe to use across iOS/watchOS/tvOS/macOS/visionOS.
public struct LocalStorageDirectories: Sendable {
    /// Creates a new directory provider.
    public init() {}

    /// Returns the base application support directory for the current platform.
    /// - Returns: A URL suitable for app-private persistent data.
    /// - Throws: If the directory cannot be resolved or created.
    public func applicationSupportDirectory() throws -> URL {
        let fm = FileManager.default

        #if os(macOS)
        let base = try fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        #else
        let base = try fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        #endif

        return base
    }

    /// Returns the directory where Flow payload files are stored.
    /// - Throws: If the directory cannot be created.
    public func flowsDirectory() throws -> URL {
        let base = try applicationSupportDirectory()
        let dir = base.appendingPathComponent("Kokuhaku", isDirectory: true)
            .appendingPathComponent("Flows", isDirectory: true)

        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }
}
