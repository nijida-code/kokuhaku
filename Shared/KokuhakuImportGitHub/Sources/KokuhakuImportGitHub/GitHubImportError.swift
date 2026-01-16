import Foundation

/// Errors thrown by `KokuhakuImportGitHub`.
public enum GitHubImportError: Error, Sendable, LocalizedError {
    case invalidURL(String)
    case httpStatus(Int)
    case network(String)
    case decoding(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let msg),
             .network(let msg),
             .decoding(let msg):
            return msg
        case .httpStatus(let code):
            return "GitHub request failed with HTTP status \(code)."
        }
    }
}
