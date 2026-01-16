import Foundation

/// Errors thrown by `KokuhakuHealthKit`.
public enum HealthKitError: Error, Sendable, LocalizedError {
    /// The user denied HealthKit authorization or it could not be obtained.
    case authorizationDenied

    /// HealthKit is not available on this device.
    case notAvailable

    public var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "HealthKit authorization was denied."
        case .notAvailable:
            return "HealthKit is not available on this device."
        }
    }
}
