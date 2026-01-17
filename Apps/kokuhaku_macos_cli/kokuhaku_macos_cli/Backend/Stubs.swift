import Foundation

// MARK: - Stub Backend Implementations (temporary)

/// A very small, file-based stub repository.
///
/// This is only intended to make the CLI runnable during early scaffolding.
/// Replace with your real storage implementation (likely in KokuhakuCore).
public final class FileFlowRepository: FlowRepository, @unchecked Sendable {
    private let storageDir: URL
    private let fileManager: FileManager

    public init(storageDir: URL, fileManager: FileManager = .default) {
        self.storageDir = storageDir
        self.fileManager = fileManager
    }

    public func importFiles(urls: [URL]) throws -> [FlowDTO] {
        try ensureStorageDirExists()
        var imported: [FlowDTO] = []
        for url in urls {
            let dto = try storeFlow(from: url)
            imported.append(dto)
        }
        return imported
    }

    public func exportFlow(id: String, to destination: URL) throws {
        let source = storageDir.appendingPathComponent("\(id).json")
        guard fileManager.fileExists(atPath: source.path) else {
            throw CocoaError(.fileNoSuchFile)
        }
        try ensureParentExists(for: destination)
        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }
        try fileManager.copyItem(at: source, to: destination)
    }

    public func createFlow(name: String?, templateURL: URL?) throws -> FlowDTO {
        try ensureStorageDirExists()
        let id = UUID().uuidString.lowercased()
        let dto = FlowDTO(id: id, name: name ?? "Untitled")
        let out = storageDir.appendingPathComponent("\(id).json")

        if let templateURL {
            try ensureParentExists(for: out)
            if fileManager.fileExists(atPath: out.path) { try fileManager.removeItem(at: out) }
            try fileManager.copyItem(at: templateURL, to: out)
        } else {
            let data = try JSONEncoder().encode(dto)
            try data.write(to: out, options: [.atomic])
        }

        return dto
    }

    public func storeFlow(from url: URL) throws -> FlowDTO {
        try ensureStorageDirExists()

        // Very simple: try to decode FlowDTO; if that fails, store as raw JSON and synthesize DTO.
        let data = try Data(contentsOf: url)
        let dto: FlowDTO
        if let decoded = try? JSONDecoder().decode(FlowDTO.self, from: data) {
            dto = decoded
        } else {
            dto = FlowDTO(id: UUID().uuidString.lowercased(), name: url.deletingPathExtension().lastPathComponent)
        }

        let out = storageDir.appendingPathComponent("\(dto.id).json")
        try data.write(to: out, options: [.atomic])
        return dto
    }

    public func markFlow(id: String, target: DeviceTarget) throws {
        try ensureStorageDirExists()
        let marksURL = storageDir.appendingPathComponent("marks.json")
        var marks: [String: [String]] = [:] // id -> targets
        if let data = try? Data(contentsOf: marksURL),
           let decoded = try? JSONDecoder().decode([String: [String]].self, from: data) {
            marks = decoded
        }
        var set = Set(marks[id] ?? [])
        set.insert(target.rawValue)
        marks[id] = Array(set).sorted()
        let out = try JSONEncoder().encode(marks)
        try out.write(to: marksURL, options: [.atomic])
    }

    public func loadFlow(id: String) throws -> FlowDTO {
        let url = storageDir.appendingPathComponent("\(id).json")
        let data = try Data(contentsOf: url)
        if let decoded = try? JSONDecoder().decode(FlowDTO.self, from: data) {
            return decoded
        }
        // If the stored JSON isn't a FlowDTO, at least surface something stable.
        return FlowDTO(id: id, name: "Flow \(id)")
    }

    private func ensureStorageDirExists() throws {
        if !fileManager.fileExists(atPath: storageDir.path) {
            try fileManager.createDirectory(at: storageDir, withIntermediateDirectories: true)
        }
    }

    private func ensureParentExists(for url: URL) throws {
        let parent = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: parent.path) {
            try fileManager.createDirectory(at: parent, withIntermediateDirectories: true)
        }
    }
}

/// A stub catalog provider.
///
/// "local" source reads JSON files from a directory; "github" is TODO.
public final class StubCatalogProvider: CatalogProvider, @unchecked Sendable {
    private let localCatalogDir: URL
    private let fileManager: FileManager

    public init(localCatalogDir: URL, fileManager: FileManager = .default) {
        self.localCatalogDir = localCatalogDir
        self.fileManager = fileManager
    }

    public func list(source: String) throws -> [CatalogEntryDTO] {
        switch source.lowercased() {
        case "local":
            guard fileManager.fileExists(atPath: localCatalogDir.path) else { return [] }
            let files = try fileManager.contentsOfDirectory(at: localCatalogDir, includingPropertiesForKeys: nil)
            return files
                .filter { $0.pathExtension.lowercased() == "json" }
                .map { CatalogEntryDTO(entryID: $0.lastPathComponent, title: $0.deletingPathExtension().lastPathComponent) }
                .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        default:
            return []
        }
    }

    public func fetchEntry(source: String, entryID: String) throws -> URL {
        switch source.lowercased() {
        case "local":
            return localCatalogDir.appendingPathComponent(entryID)
        default:
            throw NSError(domain: "Catalog", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unsupported catalog source: \(source)"])
        }
    }
}

/// A stub CloudKit sync service.
public final class StubCloudSyncService: CloudSyncService {
    public init() {}
    public func saveToCloud(flow: FlowDTO) throws {
        // TODO: implement CloudKit upload.
    }
}

/// A stub health service.
public final class StubHealthService: HealthService {
    public init() {}
    public func report(from: Date?, to: Date?) throws -> String {
        // TODO: implement real evaluation metrics.
        return "Health report is not implemented yet."
    }

    public func enableSync() throws {
        // TODO: persist cross-device setting (CloudKit / iCloud KVS, etc).
    }

    public func disableSync() throws {
        // TODO: persist cross-device setting (CloudKit / iCloud KVS, etc).
    }
}

/// Default backend wiring for early scaffolding.
public struct DefaultBackend: Backend {
    public let flows: FlowRepository
    public let catalog: CatalogProvider
    public let cloud: CloudSyncService
    public let health: HealthService

    public init(storageDir: URL, localCatalogDir: URL) {
        self.flows = FileFlowRepository(storageDir: storageDir)
        self.catalog = StubCatalogProvider(localCatalogDir: localCatalogDir)
        self.cloud = StubCloudSyncService()
        self.health = StubHealthService()
    }
}
