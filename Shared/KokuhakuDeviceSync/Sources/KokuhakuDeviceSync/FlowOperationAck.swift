import Foundation

/// Acknowledgement for a device operation.
public struct FlowOperationAck: Sendable, Codable, Hashable {
    public enum Status: String, Sendable, Codable, Hashable {
        case ok
        case failed
    }

    /// The operation that was acknowledged (e.g. `install`, `delete`).
    public let operation: String

    /// The related Flow identifier (if applicable).
    public let flowID: String?

    /// Result status.
    public let status: Status

    /// Optional error message for diagnostics.
    public let message: String?

    public init(operation: String, flowID: String?, status: Status, message: String? = nil) {
        self.operation = operation
        self.flowID = flowID
        self.status = status
        self.message = message
    }
}
