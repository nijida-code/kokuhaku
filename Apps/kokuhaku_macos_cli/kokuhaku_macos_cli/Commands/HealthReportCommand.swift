import Foundation
import ArgumentParser

/// Shows a health evaluation summary.
struct HealthReportCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "report",
        abstract: "Show health evaluation metrics."
    )

    @OptionGroup var root: KokuhakuCLI

    /// Start date (YYYY-MM-DD).
    @Option(name: [.long], help: "Start date (YYYY-MM-DD).")
    var from: String?

    /// End date (YYYY-MM-DD).
    @Option(name: [.long], help: "End date (YYYY-MM-DD).")
    var to: String?

    mutating func run() throws {
        let ctx = try KokuhakuCLI.makeContext(
            verbose: root.verbose,
            quiet: root.quiet,
            storageDir: root.storageDir,
            catalogDir: root.catalogDir
        )

        let (fromDate, toDate) = try parseRange(from: from, to: to)
        let report = try ctx.backend.health.report(from: fromDate, to: toDate)
        Logger.info(report)
    }

    private func parseRange(from: String?, to: String?) throws -> (Date?, Date?) {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"

        var fromDate: Date? = nil
        var toDate: Date? = nil

        if let from { fromDate = formatter.date(from: from) }
        if let to { toDate = formatter.date(from: to) }

        if (from != nil && fromDate == nil) || (to != nil && toDate == nil) {
            throw ValidationError("Dates must be formatted as YYYY-MM-DD.")
        }

        return (fromDate, toDate)
    }
}
