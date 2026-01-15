import Foundation

public enum FlowParseError: Error, LocalizedError {
	case missingOrUnsupportedVersion(String?)
	case malformedJSON

	public var errorDescription: String? {
		switch self {
		case .missingOrUnsupportedVersion(let v):
			return "Unsupported or missing Flow JSON version: \(v ?? "nil")"
		case .malformedJSON:
			return "Malformed JSON"
		}
	}
}

public func parseData(_ data: Data) throws -> Flow {
	let decoder: JSONDecoder = JSONDecoder()

	private struct VersionCheck: Codable {
		let version: String
	}

	// 1) Version lesen
	let header: VersionCheck
	do {
		header = try decoder.decode(VersionCheck.self, from: data)
	} catch {
		throw FlowParseError.malformedJSON
	}

	// 2) Mapper wählen
	guard let mapper = FlowMapperFactory.mapper(for: header.version) else {
		throw FlowParseError.missingOrUnsupportedVersion(header.version)
	}

	// 3) Zur aktuellen Version mappen
	return try mapper.map(data: data, decoder: decoder)
}
