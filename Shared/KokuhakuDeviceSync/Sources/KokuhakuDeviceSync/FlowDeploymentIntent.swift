import Foundation

/// Stores the user's intent where a Flow should be deployed.
///
/// This is typically created on a management device and synced/stored
/// alongside the Flow catalog state.
public struct FlowDeploymentIntent: Sendable, Codable, Hashable {
    /// Stable Flow identifier (project-defined).
    public let flowID: String

    /// Which device targets should receive this Flow.
    public let targets: Set<DeviceTarget>

    /// Creates a new deployment intent.
    public init(flowID: String, targets: Set<DeviceTarget>) {
        self.flowID = flowID
        self.targets = targets
    }
}
