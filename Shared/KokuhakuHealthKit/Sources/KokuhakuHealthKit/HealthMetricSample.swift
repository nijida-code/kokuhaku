import Foundation

/// A Kokuhaku-neutral representation of a HealthKit metric sample.
///
/// This DTO allows analytics/storage code to stay independent of HealthKit types.
public struct HealthMetricSample: Sendable, Codable, Hashable {
    /// A metric identifier (e.g. `heartRate`, `hrv`, `steps`).
    public let metric: String

    /// Numeric value (unit interpretation is defined by `unit`).
    public let value: Double

    /// Unit string for the metric value (e.g. `count/min`, `ms`).
    public let unit: String

    /// Sample start timestamp.
    public let startDate: Date

    /// Sample end timestamp.
    public let endDate: Date

    public init(metric: String, value: Double, unit: String, startDate: Date, endDate: Date) {
        self.metric = metric
        self.value = value
        self.unit = unit
        self.startDate = startDate
        self.endDate = endDate
    }
}
