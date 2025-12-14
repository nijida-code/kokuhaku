import Foundation

public struct KokuhakuEngine {

    public init() {}

    public func validate(set: KokuhakuSet) -> Bool {
        !set.steps.isEmpty && set.steps.allSatisfy { $0.durationSeconds > 0 }
    }
}
