import Foundation

/// The intended device class for a deployed Flow.
public enum DeviceTarget: String, Sendable, Codable, Hashable {
    case watch
    case tv
}
