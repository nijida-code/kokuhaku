import Foundation

// MARK: - Flow
public struct Flow: Codable {
	public let version, uuid, hash: String
	public let name, description, longDescription: [String: String]
	public let flow: [Step]
	private enum CodingKeys: String, CodingKey {
		case version, uuid, hash, name, description, flow
		case longDescription = "long_description"
	}
}

// MARK: - Step
public struct Step: Codable {
	public let step: String
	public let duration: Int?
	public let unit: String
	public let notifications: [Notification]?
}

// MARK: - Notification
public struct Notification: Codable {
	public let notificationRepeat: Repeat?
	public let start, end: Limiter?

	private enum CodingKeys: String, CodingKey {
		case notificationRepeat = "repeat"
		case start, end
	}
}

// MARK: - Repeat
public struct Repeat: Codable {
	public let interval: Int
	public let unit: String
	public let escalation: Escalation?
}

// MARK: - Escalation
public struct Escalation: Codable {
	public let factor: Float
	private let _function: Function?
	public var function: Function { _function ?? .linear }

	private enum CodingKeys: String, CodingKey {
		case factor
		case _function = "function"
	}
}

// MARK: - Limiter
public struct Limiter: Codable {
	private let _offset: Int
	public var offset: Int {
		if relativeTo == .startOfStep {
			max(0, _offset)
		} else {
			_offset
		}
	}
	public let unit: Unit
	public let relativeTo: RelativeTo

	private enum CodingKeys: String, CodingKey {
		case unit
		case relativeTo = "relative_to"
		case _offset = "offset"
	}
}

// MARK: - RelativeTo
public enum RelativeTo: String, Codable {
	case startOfStep = "start_of_step"
	case endOfStep = "end_of_step"
}

// MARK: - Unit
public enum Unit: String, Codable {
	case seconds
	case minutes
	case hours
}

// MARK: - Function
public enum Function: String, Codable {
	case linear
	case exponential
	case logarithmic
}
