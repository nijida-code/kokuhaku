import Foundation

/// A suggested delivery channel for a notification request.
///
/// Implementations may ignore channels that are not available on a device.
public enum NotificationChannel: String, Sendable, Codable, Hashable {
    /// Haptic/tactile feedback (watchOS).
    case haptic

    /// Audio feedback (tvOS, iOS, etc.).
    case audio

    /// Visual feedback such as a flash overlay (tvOS) or on-screen cue.
    case visual

    /// System notification (iOS/macOS/visionOS).
    case system
}
