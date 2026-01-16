import Foundation

/// A protocol implemented by platform-specific notification/feedback adapters.
///
/// Implementations should be lightweight and non-blocking.
/// They must decide how to map `NotificationRequest` onto device capabilities.
public protocol NotificationDelivering: Sendable {
    /// Requests delivery of a notification with an optional delivery plan.
    /// - Parameters:
    ///   - request: The notification request.
    ///   - plan: Preferred channels. Implementations may ignore unavailable channels.
    func deliver(_ request: NotificationRequest, plan: NotificationDeliveryPlan?) async throws
}
