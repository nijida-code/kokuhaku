import Foundation
import HealthKit

/// A minimal reader for HealthKit data.
///
/// This type provides async-friendly convenience methods to read common samples.
/// It returns Kokuhaku-neutral DTOs instead of HealthKit types.
public struct HealthKitReader: Sendable {
    private let store: HKHealthStore

    /// Creates a new HealthKit reader.
    /// - Parameter store: The HealthKit store instance.
    public init(store: HKHealthStore = HKHealthStore()) {
        self.store = store
    }

    /// Reads the most recent quantity sample for a given quantity type identifier.
    /// - Parameters:
    ///   - identifier: The HealthKit quantity type identifier.
    ///   - unit: The unit to convert the sample into.
    /// - Returns: The most recent sample, or `nil` if none exists.
    public func readMostRecentQuantitySample(
        identifier: HKQuantityTypeIdentifier,
        unit: HKUnit
    ) async throws -> HealthMetricSample? {
        guard let type = HKObjectType.quantityType(forIdentifier: identifier) else { return nil }

        let sort = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: type,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sort]
        ) { _, samples, error in
            // handled below via continuation
        }

        return try await withCheckedThrowingContinuation { cont in
            let q = HKSampleQuery(
                sampleType: type,
                predicate: nil,
                limit: 1,
                sortDescriptors: [sort]
            ) { _, samples, error in
                if let error {
                    cont.resume(throwing: error)
                    return
                }
                guard let sample = samples?.first as? HKQuantitySample else {
                    cont.resume(returning: nil)
                    return
                }

                let value = sample.quantity.doubleValue(for: unit)

                let dto = HealthMetricSample(
                    metric: identifier.rawValue,
                    value: value,
                    unit: unit.unitString,
                    startDate: sample.startDate,
                    endDate: sample.endDate
                )
                cont.resume(returning: dto)
            }

            store.execute(q)
        }
    }
}
