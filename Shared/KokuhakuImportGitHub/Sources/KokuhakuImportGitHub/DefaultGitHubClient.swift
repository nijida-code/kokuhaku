import Foundation

/// Default implementation of `GitHubClient` backed by `URLSession`.
///
/// This implementation is suitable for public repositories without authentication.
/// Token-based authentication can be added later.
public struct DefaultGitHubClient: GitHubClient, Sendable {
    private let session: URLSession

    /// Creates a new client.
    /// - Parameter session: The URLSession used for requests.
    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func listContents(spec: GitHubRepositorySpec, path: String?) async throws -> [GitHubContentItem] {
        let owner = spec.owner
        let repo = spec.repository

        let basePath = path ?? spec.rootPath ?? ""
        let normalizedPath = basePath.trimmingCharacters(in: CharacterSet(charactersIn: "/"))

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(owner)/\(repo)/contents/\(normalizedPath)"

        var queryItems: [URLQueryItem] = []
        if let ref = spec.ref, !ref.isEmpty {
            queryItems.append(URLQueryItem(name: "ref", value: ref))
        }
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw GitHubImportError.invalidURL("Could not build GitHub contents URL.")
        }

        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")

        let (data, response) = try await session.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw GitHubImportError.network("Non-HTTP response.")
        }
        guard (200...299).contains(http.statusCode) else {
            throw GitHubImportError.httpStatus(http.statusCode)
        }

        // Note: GitHub returns either an array (directory) or an object (file). We handle directory only here.
        do {
            return try JSONDecoder().decode([GitHubContentItem].self, from: data)
        } catch {
            throw GitHubImportError.decoding("Failed to decode contents response: \(error)")
        }
    }

    public func downloadFile(downloadURL: URL) async throws -> Data {
        let (data, response) = try await session.data(from: downloadURL)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw GitHubImportError.network("Download failed.")
        }
        return data
    }
}
