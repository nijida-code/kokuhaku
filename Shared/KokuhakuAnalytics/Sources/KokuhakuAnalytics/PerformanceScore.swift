import Foundation

/// A normalized performance score for a Flow run or day.
public struct PerformanceScore: Sendable, Codable, Hashable {
    /// Score value in range 0.0 ... 1.0.
    public let value: Double

    /// Optional explanation or diagnostic note.
    public let note: String?

    public init(value: Double, note: String? = nil) {
        self.value = value
        self.note = note
    }
}
