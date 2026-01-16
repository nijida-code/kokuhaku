import Foundation

/// Scans local directories for Kokuhaku Flow files.
///
/// This scanner is intentionally lightweight:
/// it does not parse the Flow payload; it only returns file descriptors.
public struct LocalFlowDirectoryScanner: Sendable {
    public init() {}

    /// Returns Flow file descriptors for all supported Flow files in the given directory (non-recursive).
    /// - Parameter directoryURL: The directory to scan.
    /// - Returns: A list of discovered Flow file descriptors.
    /// - Throws: If the directory cannot be enumerated.
    public func scan(directoryURL: URL) throws -> [FlowFileDescriptor] {
        let fm = FileManager.default

        let contents = try fm.contentsOfDirectory(
            at: directoryURL,
            includingPropertiesForKeys: [.fileSizeKey, .contentModificationDateKey],
            options: [.skipsHiddenFiles]
        )

        var result: [FlowFileDescriptor] = []
        result.reserveCapacity(contents.count)

        for url in contents {
            guard let format = Self.detectFormat(url: url) else { continue }

            let values = try? url.resourceValues(forKeys: [.fileSizeKey, .contentModificationDateKey])

            let descriptor = FlowFileDescriptor(
                url: url,
                format: format,
                fileName: url.lastPathComponent,
                fileSizeBytes: values?.fileSize.map(Int64.init),
                modifiedAt: values?.contentModificationDate
            )
            result.append(descriptor)
        }

        return result.sorted { $0.fileName.localizedStandardCompare($1.fileName) == .orderedAscending }
    }

    /// Detects the Flow file format based on file extension.
    /// - Parameter url: A candidate file URL.
    /// - Returns: The detected format, or `nil` if not supported.
    public static func detectFormat(url: URL) -> LocalFlowFileFormat? {
        switch url.pathExtension.lowercased() {
        case "json": return .json
        case "xml": return .xml
        default: return nil
        }
    }
}
