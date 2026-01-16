import Foundation

/// A lightweight description of a locally stored Flow payload.
///
/// This is used to build lists (table views) without decoding the Flow yet.
public struct StoredFlowDescriptor: Sendable, Hashable {
    /// A stable identifier used as filename/key.
    public let id: String

    /// File URL where the payload is stored.
    public let fileURL: URL

    /// Last modification timestamp if available.
    public let modifiedAt: Date?

    /// Payload format (e.g. `json`, `xml`).
    public let fileExtension: String

    /// Creates a new descriptor.
    public init(id: String, fileURL: URL, modifiedAt: Date?, fileExtension: String) {
        self.id = id
        self.fileURL = fileURL
        self.modifiedAt = modifiedAt
        self.fileExtension = fileExtension
    }
}
