import XCTest
@testable import Data
@testable import Domain

final class ExoplanetRepositoryTests: XCTestCase {

    // MARK: - Success Cases (Unit Tests)
    func test_fetchExoplanets_withSuccessfulResponse_shouldReturnExoplanets() async throws {
        // Given
        let exoplanets = [TestFactory.makeExoplanet(identifier: "Test")]
        let sut = TestFactory.Unit.makeRepository(exoplanets: exoplanets)

        // When
        let result = try await sut.fetchExoplanets()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.planetIdentifier, "Test")
    }

    // MARK: - Error Cases (Unit Tests)
    func test_fetchExoplanets_withNetworkError_shouldPropagateError() async {
        // Given
        let networkError = NetworkError.badStatus(404)
        let sut = TestFactory.Unit.makeRepository(error: networkError)

        // When/Then
        do {
            _ = try await sut.fetchExoplanets()
        } catch let error as NetworkError {
            XCTAssertEqual(error, networkError)
        } catch {
            XCTFail("Expected error to be thrown")
        }
    }

    // MARK: - Retry Cases (Unit Tests)
    func test_fetchExoplanets_withRetryConfig_shouldRetryOnFailure() async {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0.1)
        let networkError = NetworkError.badStatus(500)
        let sut = TestFactory.Unit.makeRepository(error: networkError, config: config)

        // When/Then
        do {
            _ = try await sut.fetchExoplanets()
            XCTFail("Expected error after retries")
        } catch {
            do {
                let mockDataSource = try XCTUnwrap(Mirror(reflecting: sut)
                    .children
                    .first { $0.label == "dataSource" }?.value as? MockExoplanetDataSource)
                XCTAssertEqual(mockDataSource.fetchCallCount, config.maxAttempts)
            } catch {
                XCTFail("Not expectet error")
            }
        }
    }

    // MARK: - Integration Tests
    func test_fetchExoplanets_withRealImplementation_shouldReturnData() async throws {
        // Given
        let sut = TestFactory.Integration.makeRepository()

        // When
        let result = try await sut.fetchExoplanets()

        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertNotNil(result.first?.planetIdentifier)
    }
}
