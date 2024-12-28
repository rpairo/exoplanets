import Foundation
import Domain

public final class RemoteExoplanetDataSource: ExoplanetDataSource {
    private let client: HTTPClient
    private let url: URL
    private let decoder: JSONDecoder

    public init(client: HTTPClient, url: URL, decoder: JSONDecoder = .init()) {
        self.client = client
        self.url = url
        self.decoder = decoder
    }

    public func fetch() async throws -> [Exoplanet] {
        let data = try await client.get(from: url)
        return try decoder.decode([Exoplanet].self, from: data)
    }
}
