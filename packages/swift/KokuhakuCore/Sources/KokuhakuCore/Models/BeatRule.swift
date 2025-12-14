import Foundation

public enum BeatRule: Codable, Hashable {
    case repeatEvery(seconds: Int)
    case beforeEnd(seconds: Int)
    case afterEndOnce(seconds: Int)
    case afterEndRepeat(seconds: Int)
}
