import Foundation
import HealthKit

/// Utilities to check HealthKit availability on the current device.
public enum HealthKitAvailability: Sendable {
    /// Returns whether HealthKit is available on this device.
    ///
    /// Note: Even if HealthKit is available, the user may still deny authorization.
    public static func isHealthDataAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable()
    }
}
