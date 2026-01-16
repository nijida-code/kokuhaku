import Foundation

/// High-level messages exchanged between management and runner devices.
///
/// This is intentionally simple and Codable-friendly.
public enum DeviceSyncMessage: Sendable, Codable, Hashable {
    /// Install or update a Flow payload on the target device.
    case installFlow(FlowPayloadEnvelope)

    /// Remove a Flow from the target device.
    case deleteFlow(flowID: String)

    /// Request a list of installed Flows from the target device.
    case listInstalled

    /// Response containing installed Flow IDs.
    case installedList(flowIDs: [String])

    /// Acknowledgement of an operation.
    case ack(FlowOperationAck)
}
