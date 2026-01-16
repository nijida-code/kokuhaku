import Foundation

/// Errors thrown by `KokuhakuStorageLocal`.
public enum LocalStorageError: Error, Sendable, LocalizedError {
    case invalidIdentifier(String)
    case notFound(String)
    case io(String)

    public var errorDescription: String? {
        switch self {
        case .invalidIdentifier(let msg),
             .notFound(let msg),
             .io(let msg):
            return msg
        }
    }
}
