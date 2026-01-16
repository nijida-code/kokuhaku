import Foundation

/// A single entry in the unified Flow catalog.
///
/// This type is designed for table/list UIs. It can represent a Flow file discovered
/// from any backend (local directory, GitHub, Git working copy, etc.).
public struct FlowCatalogEntry: Sendable, Hashable {
    /// Stable identifier for UI diffing and caching.
    public let id: String

    /// Display name (usually derived from filename or metadata).
    public let title: String

    /// Optional subtitle (e.g. source name, repository, path).
    public let subtitle: String?

    /// The origin of this entry (where it can be fetched from).
    public let origin: FlowCatalogOrigin

    /// File format hint (e.g. `json`, `xml`).
    public let format: String

    /// Optional file size (bytes) if known.
    public let sizeBytes: Int64?

    /// Optional last modification date if known.
    public let modifiedAt: Date?

    public init(
        id: String,
        title: String,
        subtitle: String?,
        origin: FlowCatalogOrigin,
        format: String,
        sizeBytes: Int64?,
        modifiedAt: Date?
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.origin = origin
        self.format = format
        self.sizeBytes = sizeBytes
        self.modifiedAt = modifiedAt
    }
}
