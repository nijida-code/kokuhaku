import Foundation

/// A GitHub repository location.
///
/// Use this to point Kokuhaku to a public (or later private) GitHub repository.
public struct GitHubRepositorySpec: Sendable, Hashable {
    /// Repository owner or organization.
    public let owner: String

    /// Repository name.
    public let repository: String

    /// Branch or tag name (defaults to the repository default branch if `nil`).
    public let ref: String?

    /// Optional path within the repository (e.g. `Flows/`).
    public let rootPath: String?

    /// Creates a new spec.
    /// - Parameters:
    ///   - owner: Repository owner or organization.
    ///   - repository: Repository name.
    ///   - ref: Branch or tag name (optional).
    ///   - rootPath: Path within the repo (optional).
    public init(owner: String, repository: String, ref: String? = nil, rootPath: String? = nil) {
        self.owner = owner
        self.repository = repository
        self.ref = ref
        self.rootPath = rootPath
    }
}
