import Foundation

/// High-level Git importer used by Kokuhaku management apps.
///
/// This type orchestrates Git checkouts and updates. It does not parse Flow files.
/// After a repository is checked out, another component (e.g. `KokuhakuImportLocal`)
/// can scan and import Flow files from the returned working directory.
public struct GitImporter: Sendable {
    private let client: any GitClient

    /// Creates a new importer.
    /// - Parameter client: The Git client implementation to use.
    public init(client: some GitClient) {
        self.client = client
    }

    /// Prepares a local working copy for the given repository.
    /// - Parameters:
    ///   - spec: Repository description.
    ///   - cacheDirectoryURL: Directory where repositories should be stored.
    /// - Returns: A checkout result containing a local working directory URL.
    public func prepareRepository(spec: GitRepositorySpec, cacheDirectoryURL: URL) async throws -> GitCheckoutResult {
        try await client.checkout(spec: spec, cacheDirectoryURL: cacheDirectoryURL)
    }

    /// Updates an existing local working copy.
    /// - Parameters:
    ///   - workingDirectoryURL: Existing working copy directory.
    ///   - spec: Repository description.
    public func updateRepository(workingDirectoryURL: URL, spec: GitRepositorySpec) async throws {
        try await client.update(workingDirectoryURL: workingDirectoryURL, spec: spec)
    }
}
