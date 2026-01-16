import Foundation

/// A transport-friendly envelope carrying a Flow payload.
///
/// The payload is raw file data (JSON/XML). Decoding and validation are performed
/// by `KokuhakuCore` on the receiving side.
public struct FlowPayloadEnvelope: Sendable, Codable, Hashable {
    /// Stable identifier used by the receiver for storage.
    public let flowID: String

    /// File format hint (e.g. `json`, `xml`).
    public let format: String

    /// Raw payload bytes (JSON/XML).
    public let payload: Data

    /// Optional human-readable name.
    public let displayName: String?

    /// Optional source info for debugging.
    public let sourceDescription: String?

    public init(
        flowID: String,
        format: String,
        payload: Data,
        displayName: String? = nil,
        sourceDescription: String? = nil
    ) {
        self.flowID = flowID
        self.format = format
        self.payload = payload
        self.displayName = displayName
        self.sourceDescription = sourceDescription
    }
}
