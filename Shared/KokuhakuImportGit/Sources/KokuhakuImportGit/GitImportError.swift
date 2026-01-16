import Foundation

/// Errors thrown by `KokuhakuImportGit`.
public enum GitImportError: Error, Sendable, LocalizedError {
    /// The platform does not support the chosen Git implementation.
    case unsupportedPlatform(String)

    /// The repository could not be accessed (network/auth/path issues).
    case repositoryAccessFailed(String)

    /// A local cache operation failed.
    case cacheFailure(String)

    public var errorDescription: String? {
        switch self {
        case .unsupportedPlatform(let msg),
             .repositoryAccessFailed(let msg),
             .cacheFailure(let msg):
            return msg
        }
    }
}
