import Foundation

/// The result of preparing a local working copy of a Git repository.
public struct GitCheckoutResult: Sendable, Hashable {
    /// Local directory URL of the checked out repository.
    public let workingDirectoryURL: URL

    /// A human-readable identifier for UI/debugging (e.g. `owner/repo`).
    public let displayName: String?

    /// Creates a new checkout result.
    public init(workingDirectoryURL: URL, displayName: String? = nil) {
        self.workingDirectoryURL = workingDirectoryURL
        self.displayName = displayName
    }
}
