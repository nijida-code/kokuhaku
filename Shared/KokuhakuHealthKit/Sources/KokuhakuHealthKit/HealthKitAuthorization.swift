import Foundation
import HealthKit

/// A small helper to request HealthKit authorization.
///
/// This type encapsulates the authorization handshake and keeps it out of the app targets.
public struct HealthKitAuthorization: Sendable {
    private let store: HKHealthStore

    /// Creates a new authorization helper.
    /// - Parameter store: The HealthKit store instance.
    public init(store: HKHealthStore = HKHealthStore()) {
        self.store = store
    }

    /// Requests authorization to read and/or write HealthKit data.
    /// - Parameters:
    ///   - toShare: Types the app wants to write (may be empty).
    ///   - toRead: Types the app wants to read (may be empty).
    public func requestAuthorization(
        toShare: Set<HKSampleType> = [],
        toRead: Set<HKObjectType> = []
    ) async throws {
        try await withCheckedThrowingContinuation { cont in
            store.requestAuthorization(toShare: toShare, read: toRead) { success, error in
                if let error {
                    cont.resume(throwing: error)
                    return
                }
                if success {
                    cont.resume()
                } else {
                    cont.resume(throwing: HealthKitError.authorizationDenied)
                }
            }
        }
    }
}