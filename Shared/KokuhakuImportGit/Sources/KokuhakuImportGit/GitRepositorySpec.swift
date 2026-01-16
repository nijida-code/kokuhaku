import Foundation

/// A description of a Git repository to import from.
///
/// This type is intentionally provider-agnostic (works for GitHub/GitLab/self-hosted).
public struct GitRepositorySpec: Sendable, Hashable {
    /// The remote URL of the repository (e.g. `https://...` or `ssh://...`).
    public let remoteURL: URL

    /// An optional branch name to check out (e.g. `main`).
    public let branch: String?

    /// An optional revision identifier (commit hash / tag).
    public let revision: String?

    /// Creates a new repository spec.
    /// - Parameters:
    ///   - remoteURL: Remote Git URL.
    ///   - branch: Branch to use (optional).
    ///   - revision: Commit hash or tag (optional).
    public init(remoteURL: URL, branch: String? = nil, revision: String? = nil) {
        self.remoteURL = remoteURL
        self.branch = branch
        self.revision = revision
    }
}
