import Foundation

/// A high-level category of Kokuhaku feedback.
///
/// This is intentionally generic so it can be mapped to device-specific capabilities
/// such as haptics (watchOS), audio/visual cues (tvOS), or system notifications (iOS).
public enum NotificationKind: String, Sendable, Codable, Hashable {
    /// A gentle reminder (e.g. upcoming step).
    case gentle

    /// A stronger, attention-grabbing reminder.
    case strong

    /// Immediate confirmation feedback (e.g. step completed).
    case confirmation

    /// Warning feedback (e.g. step missed or delayed).
    case warning
}
