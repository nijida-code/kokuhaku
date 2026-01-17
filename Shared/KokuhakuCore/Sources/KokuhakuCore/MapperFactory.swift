import Foundation

public protocol FlowJSONMapper: Sendable {
	/// Versionsstring, den dieser Mapper versteht (z.B. "1", "1.0", "2")
	static var supportedVersion: String { get }

	/// Baut aus JSON (dieser Version) ein aktuelles `Flow`
	func map(data: Data, decoder: JSONDecoder) throws -> Flow
}

public enum FlowMapperFactory {
	private static let mappers: [String: any FlowJSONMapper] = [
		FlowV1Mapper.supportedVersion: FlowV1Mapper()
	]

	public static func mapper(for version: String) -> (any FlowJSONMapper)? {
		mappers[version]
	}
}
