import Foundation

// private struct FlowDTOv1: Codable {
// }

public struct FlowV1Mapper: FlowJSONMapper {
	public static let supportedVersion = "1.0"

	public init() {}

	public func map(data: Data, decoder: JSONDecoder) throws -> Flow {
		// let dto = try decoder.decode(FlowDTOv1.self, from: data)
		// return Flow(
		// )
		return try decoder.decode(Flow.self, from: data)
	}
}
