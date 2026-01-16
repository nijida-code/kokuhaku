import Foundation

/// A delivery plan describing preferred channels for a notification.
///
/// The platform implementation should choose the best available subset.
public struct NotificationDeliveryPlan: Sendable, Codable, Hashable {
    /// Preferred channels in priority order.
    public let preferredChannels: [NotificationChannel]

    public init(preferredChannels: [NotificationChannel]) {
        self.preferredChannels = preferredChannels
    }

    /// A sensible default for runner devices (watchOS/tvOS).
    public static let runnerDefault = NotificationDeliveryPlan(
        preferredChannels: [.haptic, .audio, .visual]
    )
}
