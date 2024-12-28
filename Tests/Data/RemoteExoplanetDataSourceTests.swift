import XCTest
@testable import Data
@testable import Domain

final class RemoteExoplanetDataSourceTests: XCTestCase {
    func test_fetch_withValidData_shouldReturnExoplanets() async throws {
        // Given
        let url = URL(string: "https://test.com")!
        let client = MockHTTPClient(result: .success(TestData.validExoplanet))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When
        let exoplanets = try await sut.fetch()

        // Then
        XCTAssertEqual(exoplanets.count, 1)
        XCTAssertEqual(exoplanets.first?.planetIdentifier, "Valid Planet")
        XCTAssertEqual(exoplanets.first?.typeFlag, 3)
        XCTAssertEqual(exoplanets.first?.radiusJpt, 1.5)
        XCTAssertEqual(exoplanets.first?.hostStarTempK, 5000)
        XCTAssertEqual(exoplanets.first?.discoveryYear, 2000)
    }

    func test_fetch_withEmptyData_shouldReturnEmptyArray() async throws {
        // Given
        let url = URL(string: "https://test.com")!
        let client = MockHTTPClient(result: .success(TestData.emptyJSON))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When
        let exoplanets = try await sut.fetch()

        // Then
        XCTAssertTrue(exoplanets.isEmpty)
    }

    func test_fetch_withNetworkError_shouldThrowError() async {
        // Given
        let url = URL(string: "https://test.com")!
        let networkError = NetworkError.badStatus(404)
        let client = MockHTTPClient(result: .failure(networkError))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When/Then
        do {
            _ = try await sut.fetch()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? NetworkError, networkError)
        }
    }

    func test_fetch_withEmptyStrings_shouldDecodeToNil() async throws {
        // Given
        let url = URL(string: "https://test.com")!
        let client = MockHTTPClient(result: .success(TestData.emptyStringsJSON))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When
        let exoplanets = try await sut.fetch()

        // Then
        XCTAssertEqual(exoplanets.count, 1)
        XCTAssertEqual(exoplanets.first?.planetIdentifier, "Test Planet")
        XCTAssertNil(exoplanets.first?.typeFlag)
        XCTAssertNil(exoplanets.first?.radiusJpt)
        XCTAssertNil(exoplanets.first?.hostStarTempK)
        XCTAssertNil(exoplanets.first?.discoveryYear)
    }

    func test_fetch_withMixedValues_shouldDecodeCorrectly() async throws {
        // Given
        let url = URL(string: "https://test.com")!
        let client = MockHTTPClient(result: .success(TestData.mixedStringsJSON))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When
        let exoplanets = try await sut.fetch()

        // Then
        XCTAssertEqual(exoplanets.count, 1)
        XCTAssertEqual(exoplanets.first?.planetIdentifier, "Mixed Planet")
        XCTAssertEqual(exoplanets.first?.typeFlag, 3)
        XCTAssertEqual(exoplanets.first?.radiusJpt, 1.5)
        XCTAssertNil(exoplanets.first?.hostStarTempK)
        XCTAssertEqual(exoplanets.first?.discoveryYear, 2000)
    }

    func test_fetch_withExtremeValues_shouldDecodeCorrectly() async throws {
        // Given
        let url = URL(string: "https://test.com")!
        let client = MockHTTPClient(result: .success(TestData.extremeValuesJSON))
        let sut = RemoteExoplanetDataSource(client: client, url: url)

        // When
        let exoplanets = try await sut.fetch()

        // Then
        XCTAssertEqual(exoplanets.count, 1)
        XCTAssertEqual(exoplanets.first?.planetIdentifier, "Extreme Values")
        XCTAssertEqual(exoplanets.first?.typeFlag, Int.max)
        XCTAssertEqual(exoplanets.first?.hostStarTempK, Int.max)
        XCTAssertEqual(exoplanets.first?.discoveryYear, Int.max)
    }
}
