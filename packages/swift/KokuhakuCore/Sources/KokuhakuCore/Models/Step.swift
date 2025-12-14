import Foundation

public struct KokuhakuStep: Identifiable, Codable, Hashable {
    public let id: UUID
    public var title: String
    public var durationSeconds: Int
    public var beatRules: [BeatRule]

    public init(
        id: UUID = UUID(),
        title: String,
        durationSeconds: Int,
        beatRules: [BeatRule] = []
    ) {
        self.id = id
        self.title = title
        self.durationSeconds = durationSeconds
        self.beatRules = beatRules
    }
}
