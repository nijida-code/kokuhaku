import Foundation

/// Describes where a catalog entry can be loaded from.
public enum FlowCatalogOrigin: Sendable, Hashable {
    /// A local file URL (e.g. within Files.app or app sandbox).
    case localFile(url: URL)

    /// A GitHub file download URL (raw content).
    case gitHubFile(downloadURL: URL)

    /// A path inside a local Git working copy directory.
    case gitWorkingCopyFile(workingDirectoryURL: URL, relativePath: String)
}
