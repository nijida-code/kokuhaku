import Foundation

/// Contextual information for a calendar day.
public struct ContextDay: Sendable, Codable, Hashable {
    /// Calendar date (normalized to midnight).
    public let date: Date

    /// Indicates a weekend day.
    public let isWeekend: Bool

    /// Indicates a public holiday.
    public let isHoliday: Bool

    /// Indicates vacation/leave.
    public let isVacation: Bool

    public init(date: Date, isWeekend: Bool, isHoliday: Bool, isVacation: Bool) {
        self.date = date
        self.isWeekend = isWeekend
        self.isHoliday = isHoliday
        self.isVacation = isVacation
    }
}
