import Foundation

public struct KokuhakuSet: Identifiable, Codable, Hashable {
    public let id: UUID
    public var name: String
    public var steps: [KokuhakuStep]

    public init(
        id: UUID = UUID(),
        name: String,
        steps: [KokuhakuStep] = []
    ) {
        self.id = id
        self.name = name
        self.steps = steps
    }
}
