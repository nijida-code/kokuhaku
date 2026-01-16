import Foundation

/// Supported on-disk formats for Kokuhaku Flow files.
public enum LocalFlowFileFormat: String, Sendable {
    /// JSON format (`.json`)
    case json
    /// XML format (`.xml`) – reserved for future support.
    case xml
}
