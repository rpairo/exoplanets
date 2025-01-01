import XCTest
@testable import Data
@testable import Domain

final class RemoteExoplanetDataSourceTests: XCTestCase {
    // MARK: - Mock HTTPClient
    final class MockHTTPClient: HTTPClient {
        var mockedData: Data?
        var shouldThrowError = false

        func get(from url: URL) async throws -> Data {
            if shouldThrowError {
                throw NSError(domain: "Test", code: 1, userInfo: nil)
            }
            return mockedData ?? Data()
        }
    }

    // MARK: - Tests
    func test_fetch_withValidResponse_shouldReturnExoplanets() async throws {
        let mockClient = MockHTTPClient()
        let jsonData = "[{\"PlanetIdentifier\": \"PlanetA\", \"TypeFlag\": 1, \"PlanetaryMassJpt\": 1.0, \"RadiusJpt\": 1.1, \"DiscoveryYear\": 2022}, {\"PlanetIdentifier\": \"PlanetB\", \"TypeFlag\": 2, \"PlanetaryMassJpt\": 0.5, \"RadiusJpt\": 0.6, \"DiscoveryYear\": 2021}]".data(using: .utf8)!
        mockClient.mockedData = jsonData

        let dataSource = RemoteExoplanetDataSource(client: mockClient, url: URL(string: "https://test.com")!)

        let result = try await dataSource.fetch()
        XCTAssertEqual(result.count, 2, "Should decode 2 exoplanets from valid JSON")
        XCTAssertEqual(result.first?.planetIdentifier, "PlanetA", "First exoplanet identifier should match")
    }

    func test_fetch_withInvalidJSON_shouldThrowError() async {
        let mockClient = MockHTTPClient()
        mockClient.mockedData = "Invalid JSON".data(using: .utf8)

        let dataSource = RemoteExoplanetDataSource(client: mockClient, url: URL(string: "https://test.com")!)

        do {
            _ = try await dataSource.fetch()
            XCTFail("Fetch should throw an error for invalid JSON")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }
}
