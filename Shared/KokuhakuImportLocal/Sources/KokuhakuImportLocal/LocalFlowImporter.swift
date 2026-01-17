import Foundation
import KokuhakuCore

/// Imports Kokuhaku Flows from local files.
///
/// The importer delegates decoding/validation to `KokuhakuCore`.
/// This keeps the import backend thin and makes format evolution (versioned mapping)
/// a responsibility of the core domain layer.
public struct LocalFlowImporter: Sendable {
    public init() {}

    /// Loads a Flow from a local file URL.
    /// - Parameter fileURL: A URL pointing to a `.json` (or future `.xml`) Flow file.
    /// - Returns: The decoded `Flow`.
    /// - Throws: If the file cannot be read or decoded.
    public func importFlow(from fileURL: URL) throws -> Flow {
        let data = try Data(contentsOf: fileURL)

        switch LocalFlowDirectoryScanner.detectFormat(url: fileURL) {
        case .some(.json):
            // Adjust this call to match your actual Core API.
            // If your Core exposes `Parser.parseData(_:) -> Flow`, call that here.
            return try KokuhakuCore.parseData(data)

        case .some(.xml):
            throw LocalImportError.unsupportedFormat("XML import is not implemented yet.")

        case .none:
            throw LocalImportError.unsupportedFormat("Unsupported file extension: \(fileURL.pathExtension)")
        }
    }
}

/// Errors thrown by `KokuhakuImportLocal`.
public enum LocalImportError: Error, Sendable, LocalizedError {
    case unsupportedFormat(String)

    public var errorDescription: String? {
        switch self {
        case .unsupportedFormat(let message):
            return message
        }
    }
}
