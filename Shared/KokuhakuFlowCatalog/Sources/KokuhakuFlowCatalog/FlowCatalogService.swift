import Foundation
import KokuhakuImportLocal
import KokuhakuImportGitHub
import KokuhakuImportGit

/// Builds and refreshes Flow catalog entries from multiple sources.
///
/// This service is intentionally non-UI and non-MainActor.
public struct FlowCatalogService: Sendable {
    private let localScanner: LocalFlowDirectoryScanner
    private let gitHubClient: any GitHubClient

    /// Creates a new catalog service.
    /// - Parameters:
    ///   - localScanner: Scanner for local directories.
    ///   - gitHubClient: GitHub client used for repository listing and downloads.
    public init(
        localScanner: LocalFlowDirectoryScanner = LocalFlowDirectoryScanner(),
        gitHubClient: some GitHubClient = DefaultGitHubClient()
    ) {
        self.localScanner = localScanner
        self.gitHubClient = gitHubClient
    }

    /// Builds catalog entries from a local directory (non-recursive).
    /// - Parameter directoryURL: Directory containing Flow files.
    /// - Returns: Table-ready catalog entries.
    public func catalogFromLocalDirectory(_ directoryURL: URL) throws -> [FlowCatalogEntry] {
        let descriptors = try localScanner.scan(directoryURL: directoryURL)

        return descriptors.map { d in
            FlowCatalogEntry(
                id: d.url.absoluteString,
                title: d.fileName,
                subtitle: directoryURL.lastPathComponent,
                origin: .localFile(url: d.url),
                format: d.format.rawValue,
                sizeBytes: d.fileSizeBytes,
                modifiedAt: d.modifiedAt
            )
        }
    }

    /// Builds catalog entries from a GitHub repository path.
    /// - Parameters:
    ///   - spec: GitHub repository spec.
    ///   - path: Path within the repository (optional).
    /// - Returns: Catalog entries representing Flow files.
    public func catalogFromGitHub(spec: GitHubRepositorySpec, path: String? = nil) async throws -> [FlowCatalogEntry] {
        let items = try await gitHubClient.listContents(spec: spec, path: path)

        let flowFiles = items
            .filter { $0.type == .file }
            .filter { $0.name.lowercased().hasSuffix(".json") || $0.name.lowercased().hasSuffix(".xml") }

        return flowFiles.map { item in
            FlowCatalogEntry(
                id: "\(spec.owner)/\(spec.repository):\(item.path)",
                title: item.name,
                subtitle: "\(spec.owner)/\(spec.repository)",
                origin: .gitHubFile(downloadURL: item.download_url ?? item.url ?? URL(string: "about:blank")!),
                format: item.name.lowercased().hasSuffix(".xml") ? "xml" : "json",
                sizeBytes: nil,
                modifiedAt: nil
            )
        }
    }
}
