import Foundation

// MARK: - Backend Interfaces

/// Represents a flow model used by the CLI layer.
///
/// The CLI should depend on your real Flow type from KokuhakuCore once wired up.
/// This placeholder exists so the CLI can compile independently until you connect it.
public struct FlowDTO: Codable, Sendable, Equatable {
    /// A stable identifier for the flow.
    public var id: String
    /// A human readable name.
    public var name: String

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

/// Represents a flow reference from a catalog source.
public struct CatalogEntryDTO: Sendable, Equatable {
    /// Identifier that is meaningful within the chosen catalog source.
    public var entryID: String
    /// Display name.
    public var title: String

    public init(entryID: String, title: String) {
        self.entryID = entryID
        self.title = title
    }
}

/// Indicates where a flow should be placed or marked for.
public enum DeviceTarget: String, Sendable, CaseIterable {
    case local
    case watch
    case tv
}

/// Provides persistent storage operations for flows.
///
/// Expected backing store: app-private directory / iCloud container / database, etc.
public protocol FlowRepository: Sendable {
    /// Imports flows from one or more file URLs into local storage.
    func importFiles(urls: [URL]) throws -> [FlowDTO]

    /// Exports a flow by its identifier to a destination file URL.
    func exportFlow(id: String, to destination: URL) throws

    /// Creates a new flow, optionally seeded from a template, and stores it locally.
    func createFlow(name: String?, templateURL: URL?) throws -> FlowDTO

    /// Stores a flow from a JSON file into local storage.
    func storeFlow(from url: URL) throws -> FlowDTO

    /// Marks a flow for a specific device target (watch/tv).
    func markFlow(id: String, target: DeviceTarget) throws

    /// Loads a flow from local storage by id.
    func loadFlow(id: String) throws -> FlowDTO
}

/// Provides catalog operations (local, GitHub, etc.).
public protocol CatalogProvider: Sendable {
    /// Lists entries for a given source identifier (e.g. "local", "github").
    func list(source: String) throws -> [CatalogEntryDTO]

    /// Resolves an entry into a flow JSON payload (or a local file URL).
    ///
    /// The recommended contract is to return a temporary file URL containing the JSON.
    func fetchEntry(source: String, entryID: String) throws -> URL
}

/// Provides CloudKit-backed operations.
public protocol CloudSyncService: Sendable {
    /// Saves a local flow to iCloud/CloudKit.
    func saveToCloud(flow: FlowDTO) throws
}

/// Provides health reporting and HealthKit sync configuration.
public protocol HealthService: Sendable {
    /// Returns a human-readable report for the provided date range.
    func report(from: Date?, to: Date?) throws -> String

    /// Enables HealthKit sync (conceptually for all devices under the Apple ID).
    func enableSync() throws

    /// Disables HealthKit sync.
    func disableSync() throws
}

/// Bundles all backend services used by CLI commands.
public protocol Backend: Sendable {
    var flows: FlowRepository { get }
    var catalog: CatalogProvider { get }
    var cloud: CloudSyncService { get }
    var health: HealthService { get }
}
