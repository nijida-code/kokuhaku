import Foundation

/// A minimal interface for Git operations required by Kokuhaku.
///
/// Concrete implementations may use:
/// - the system `git` executable (macOS),
/// - a bundled git implementation,
/// - or a provider-specific SDK (future).
public protocol GitClient: Sendable {
    /// Ensures a local working copy exists and is up to date.
    /// - Parameters:
    ///   - spec: Repository description.
    ///   - cacheDirectoryURL: Directory where repositories should be stored.
    /// - Returns: A local working directory that can be scanned for Flows.
    func checkout(spec: GitRepositorySpec, cacheDirectoryURL: URL) async throws -> GitCheckoutResult

    /// Updates an existing working copy (fetch/pull as appropriate).
    /// - Parameters:
    ///   - workingDirectoryURL: Existing working copy directory.
    ///   - spec: Repository description.
    func update(workingDirectoryURL: URL, spec: GitRepositorySpec) async throws
}
