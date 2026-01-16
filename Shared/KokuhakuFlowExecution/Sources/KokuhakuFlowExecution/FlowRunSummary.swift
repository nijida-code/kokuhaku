import Foundation
import KokuhakuAnalytics

/// A compact summary of a Flow run.
///
/// This type is designed to feed analytics and (later) health integrations.
public struct FlowRunSummary: Sendable, Codable, Hashable {
    public let flowID: String
    public let startedAt: Date
    public let endedAt: Date
    public let totalSteps: Int
    public let completedSteps: Int
    public let result: FlowExecutionResult

    public init(
        flowID: String,
        startedAt: Date,
        endedAt: Date,
        totalSteps: Int,
        completedSteps: Int,
        result: FlowExecutionResult
    ) {
        self.flowID = flowID
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.totalSteps = totalSteps
        self.completedSteps = completedSteps
        self.result = result
    }

    /// Converts this summary into an analytics sample.
    public func asAnalyticsSample() -> FlowRunSample {
        FlowRunSample(
            flowID: flowID,
            startedAt: startedAt,
            endedAt: endedAt,
            completedSteps: completedSteps,
            totalSteps: totalSteps
        )
    }
}
