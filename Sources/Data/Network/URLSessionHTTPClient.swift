import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func get(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        return data
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.badStatus(httpResponse.statusCode)
        }
    }
}
