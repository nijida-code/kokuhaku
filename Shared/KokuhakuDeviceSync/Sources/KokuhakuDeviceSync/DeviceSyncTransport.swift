import Foundation

/// A transport abstraction for exchanging `DeviceSyncMessage`s.
///
/// Concrete implementations may use WatchConnectivity, local networking,
/// or any other channel.
public protocol DeviceSyncTransport: Sendable {
    /// Sends a message to the paired/connected device(s).
    func send(_ message: DeviceSyncMessage) async throws

    /// Async stream of incoming messages.
    func incomingMessages() -> AsyncStream<DeviceSyncMessage>
}
