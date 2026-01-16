import Foundation
import KokuhakuCore

/// A simple local store for Flow payload files.
///
/// This store persists raw Flow payload `Data` on disk, keyed by an identifier.
/// It intentionally does not decode `Flow` itself; decoding remains in `KokuhakuCore`.
public struct LocalFlowPayloadStore: Sendable {
    private let directories: LocalStorageDirectories

    /// Creates a new local Flow payload store.
    /// - Parameter directories: Directory provider (injectable for testing).
    public init(directories: LocalStorageDirectories = LocalStorageDirectories()) {
        self.directories = directories
    }

    /// Lists all locally stored Flow payloads.
    /// - Returns: Descriptors for all stored payload files.
    public func list() throws -> [StoredFlowDescriptor] {
        let dir = try directories.flowsDirectory()
        let fm = FileManager.default

        let urls = try fm.contentsOfDirectory(
            at: dir,
            includingPropertiesForKeys: [.contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )

        var result: [StoredFlowDescriptor] = []
        result.reserveCapacity(urls.count)

        for url in urls {
            guard url.hasDirectoryPath == false else { continue }
            let id = url.deletingPathExtension().lastPathComponent
            let values = try? url.resourceValues(forKeys: [.contentModificationDateKey])
            result.append(
                StoredFlowDescriptor(
                    id: id,
                    fileURL: url,
                    modifiedAt: values?.contentModificationDate,
                    fileExtension: url.pathExtension.lowercased()
                )
            )
        }

        return result.sorted { $0.id.localizedStandardCompare($1.id) == .orderedAscending }
    }

    /// Loads the raw payload for a given Flow identifier.
    /// - Parameters:
    ///   - id: The Flow identifier (filename without extension).
    /// - Returns: Raw payload data.
    public func loadPayload(id: String) throws -> Data {
        let url = try fileURL(for: id, preferredExtension: nil)
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw LocalStorageError.notFound("No local Flow payload found for id '\(id)'.")
        }
        return try Data(contentsOf: url)
    }

    /// Saves a raw Flow payload.
    /// - Parameters:
    ///   - payload: Raw payload data (JSON/XML).
    ///   - id: Identifier used as filename (without extension).
    ///   - fileExtension: File extension such as `json` or `xml`.
    public func savePayload(_ payload: Data, id: String, fileExtension: String) throws {
        try validateIdentifier(id)

        let dir = try directories.flowsDirectory()
        let url = dir.appendingPathComponent(id).appendingPathExtension(fileExtension.lowercased())

        // Atomic write prevents partial files on crashes.
        try payload.write(to: url, options: [.atomic])
    }

    /// Deletes a stored Flow payload.
    /// - Parameter id: Identifier used as filename (without extension).
    public func deletePayload(id: String) throws {
        let dir = try directories.flowsDirectory()
        let fm = FileManager.default

        // Delete any supported extension with same base name.
        let candidates = [
            dir.appendingPathComponent(id).appendingPathExtension("json"),
            dir.appendingPathComponent(id).appendingPathExtension("xml")
        ]

        var deletedAny = false
        for url in candidates where fm.fileExists(atPath: url.path) {
            try fm.removeItem(at: url)
            deletedAny = true
        }

        if !deletedAny {
            throw LocalStorageError.notFound("No local Flow payload found for id '\(id)'.")
        }
    }

    // MARK: - Helpers

    private func fileURL(for id: String, preferredExtension: String?) throws -> URL {
        try validateIdentifier(id)
        let dir = try directories.flowsDirectory()

        if let ext = preferredExtension {
            return dir.appendingPathComponent(id).appendingPathExtension(ext.lowercased())
        }

        // Prefer JSON if present, else XML.
        let json = dir.appendingPathComponent(id).appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: json.path) { return json }

        let xml = dir.appendingPathComponent(id).appendingPathExtension("xml")
        return xml
    }

    private func validateIdentifier(_ id: String) throws {
        // Keep it conservative: only safe filename characters.
        // This prevents path traversal and weird filesystem edge cases.
        let allowed = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_")
        if id.isEmpty || id.rangeOfCharacter(from: allowed.inverted) != nil {
            throw LocalStorageError.invalidIdentifier("Invalid id '\(id)'. Allowed: a-z, A-Z, 0-9, '-', '_'")
        }
    }
}
