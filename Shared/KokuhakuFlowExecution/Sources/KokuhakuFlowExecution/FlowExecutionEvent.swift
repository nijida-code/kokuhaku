import Foundation

/// An event emitted during Flow execution.
///
/// Events are suitable for logging and analytics pipelines.
public enum FlowExecutionEvent: Sendable, Codable, Hashable {
    /// The session started.
    case sessionStarted(flowID: String, at: Date)

    /// The active step changed.
    case stepBecameActive(stepIndex: Int, at: Date)

    /// The user confirmed a step.
    case stepConfirmed(stepIndex: Int, at: Date)

    /// The session was paused.
    case sessionPaused(at: Date)

    /// The session was resumed.
    case sessionResumed(at: Date)

    /// The session ended.
    case sessionEnded(result: FlowExecutionResult, at: Date)
}
