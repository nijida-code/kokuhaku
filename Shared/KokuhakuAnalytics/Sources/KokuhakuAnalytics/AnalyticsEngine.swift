import Foundation
import KokuhakuHealthKit

/// Core analytics engine for Kokuhaku.
///
/// This type evaluates Flow execution data and optional contextual signals
/// to derive trend and performance metrics.
public struct AnalyticsEngine: Sendable {

    public init() {}

    /// Computes a performance score for a single Flow run.
    public func score(for run: FlowRunSample) -> PerformanceScore {
        guard run.totalSteps > 0 else {
            return PerformanceScore(value: 0.0, note: "No steps defined.")
        }

        let completionRatio = Double(run.completedSteps) / Double(run.totalSteps)
        return PerformanceScore(value: min(max(completionRatio, 0.0), 1.0))
    }

    /// Aggregates multiple Flow runs into a daily performance score.
    public func dailyScore(
        runs: [FlowRunSample],
        context: ContextDay,
        healthMetrics: [HealthMetricSample] = []
    ) -> PerformanceScore {
        guard !runs.isEmpty else {
            return PerformanceScore(value: 0.0, note: "No runs for day.")
        }

        let scores = runs.map { score(for: $0).value }
        let average = scores.reduce(0, +) / Double(scores.count)

        var adjusted = average

        if context.isHoliday || context.isVacation {
            adjusted *= 0.9
        }
        if context.isWeekend {
            adjusted *= 0.95
        }

        return PerformanceScore(value: min(max(adjusted, 0.0), 1.0))
    }
}
