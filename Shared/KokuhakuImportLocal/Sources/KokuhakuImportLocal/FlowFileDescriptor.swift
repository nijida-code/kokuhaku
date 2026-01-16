import Foundation

/// A lightweight description of a candidate Flow file discovered in a directory.
///
/// This type is used to build table-style overviews (file list, metadata),
/// without parsing the full Flow payload yet.
public struct FlowFileDescriptor: Sendable, Hashable {
    public let url: URL
    public let format: LocalFlowFileFormat
    public let fileName: String
    public let fileSizeBytes: Int64?
    public let modifiedAt: Date?

    /// Creates a new descriptor.
    /// - Parameters:
    ///   - url: The file URL.
    ///   - format: The detected file format.
    ///   - fileName: The last path component of `url`.
    ///   - fileSizeBytes: File size in bytes, if available.
    ///   - modifiedAt: Modification date, if available.
    public init(
        url: URL,
        format: LocalFlowFileFormat,
        fileName: String,
        fileSizeBytes: Int64?,
        modifiedAt: Date?
    ) {
        self.url = url
        self.format = format
        self.fileName = fileName
        self.fileSizeBytes = fileSizeBytes
        self.modifiedAt = modifiedAt
    }
}
