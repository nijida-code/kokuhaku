import Foundation

/// A single entry returned by the GitHub "contents" API.
public struct GitHubContentItem: Sendable, Decodable, Hashable {
    public enum ItemType: String, Sendable, Decodable {
        case file
        case dir
        case symlink
        case submodule
    }

    /// Item type (file or directory).
    public let type: ItemType

    /// Name of the entry.
    public let name: String

    /// Path within the repository.
    public let path: String

    /// API URL to fetch this item.
    public let url: URL?

    /// Direct download URL (for files), if provided.
    public let download_url: URL?

    /// Creates a new content item (mainly for tests).
    public init(type: ItemType, name: String, path: String, url: URL?, downloadURL: URL?) {
        self.type = type
        self.name = name
        self.path = path
        self.url = url
        self.download_url = downloadURL
    }
}
