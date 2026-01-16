import Foundation

/// A request to deliver user feedback or a reminder.
///
/// The request does not prescribe the exact implementation (sound, haptic pattern, flash),
/// which is decided by the platform-specific implementation.
public struct NotificationRequest: Sendable, Codable, Hashable {
    /// The category/kind of the notification.
    public let kind: NotificationKind

    /// Optional short title (if a platform supports textual output).
    public let title: String?

    /// Optional message body.
    public let body: String?

    /// Optional timestamp when the notification should be delivered.
    /// If `nil`, the notification should be delivered immediately.
    public let scheduledAt: Date?

    /// Creates a new request.
    public init(kind: NotificationKind, title: String? = nil, body: String? = nil, scheduledAt: Date? = nil) {
        self.kind = kind
        self.title = title
        self.body = body
        self.scheduledAt = scheduledAt
    }
}
