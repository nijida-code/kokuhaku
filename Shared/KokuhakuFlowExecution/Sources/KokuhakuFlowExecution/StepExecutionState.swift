import Foundation

/// Execution state for a single step within a Flow session.
public enum StepExecutionState: String, Sendable, Codable, Hashable {
    case pending
    case active
    case completed
    case skipped
}
