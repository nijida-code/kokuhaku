import Foundation

/// The final outcome of a Flow execution session.
public enum FlowExecutionResult: String, Sendable, Codable, Hashable {
    case completed
    case cancelled
    case aborted
}
