import Foundation

/// A minimal GitHub API client used by Kokuhaku.
///
/// This client focuses on repository browsing and file downloads required for Flow import.
public protocol GitHubClient: Sendable {
    /// Lists the contents of a repository path via GitHub's REST API.
    /// - Parameters:
    ///   - spec: Repository specification.
    ///   - path: Path within the repository (or `nil` for root / spec rootPath).
    /// - Returns: Items representing files and directories.
    func listContents(spec: GitHubRepositorySpec, path: String?) async throws -> [GitHubContentItem]

    /// Downloads the raw file data for a given item.
    /// - Parameter downloadURL: A direct download URL.
    /// - Returns: File contents as raw data.
    func downloadFile(downloadURL: URL) async throws -> Data
}