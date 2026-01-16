import Foundation

/// A single execution sample of a Flow.
public struct FlowRunSample: Sendable, Codable, Hashable {
    /// Flow identifier.
    public let flowID: String

    /// Timestamp when the Flow run started.
    public let startedAt: Date

    /// Timestamp when the Flow run ended.
    public let endedAt: Date

    /// Number of steps successfully completed.
    public let completedSteps: Int

    /// Total number of steps in the Flow.
    public let totalSteps: Int

    public init(
        flowID: String,
        startedAt: Date,
        endedAt: Date,
        completedSteps: Int,
        totalSteps: Int
    ) {
        self.flowID = flowID
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.completedSteps = completedSteps
        self.totalSteps = totalSteps
    }
}
