import XCTest
@testable import Data
@testable import Domain

final class RemoteExoplanetRepositoryTests: XCTestCase {
    // MARK: - Mock DataSource
    final class MockExoplanetDataSource: ExoplanetDataSource {
        var shouldThrowError = false
        var mockedExoplanets: [Exoplanet] = []

        func fetch() async throws -> [Exoplanet] {
            if shouldThrowError {
                throw NSError(domain: "Test", code: 1, userInfo: nil)
            }
            return mockedExoplanets
        }
    }

    final class MockRetryConfiguration: RetryConfiguration {
        var maxAttempts: Int = 1
        var delayBetweenAttempts: TimeInterval = 1.0
        func delay() async {

        }
    }

    // MARK: - Mock RetryHandler
    final class MockRetryableOperation: RetryableOperation {
        var configuration: RetryConfiguration = MockRetryConfiguration()
        var executeCount = 0
        var lastError: Error?

        func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T {
            for attempt in 1...configuration.maxAttempts {
                executeCount += 1
                do {
                    return try await operation()
                } catch {
                    lastError = error
                    if attempt < configuration.maxAttempts {
                        await configuration.delay()
                    }
                }
            }
            throw lastError ?? NSError(domain: "Test", code: 2, userInfo: nil)
        }
    }

    // MARK: - Tests
    func test_fetchExoplanets_withValidData_shouldReturnExoplanets() async throws {
        let dataSource = MockExoplanetDataSource()
        dataSource.mockedExoplanets = [Exoplanet(planetIdentifier: "Earth 2.0", typeFlag: 1, radiusJpt: 1.0)]

        let retryHandler = MockRetryableOperation()
        let repository = RemoteExoplanetRepository(dataSource: dataSource, retryHandler: retryHandler)

        let exoplanets = try await repository.fetchExoplanets()

        XCTAssertEqual(exoplanets.count, 1, "Repository should return 1 exoplanet")
        XCTAssertEqual(exoplanets.first?.planetIdentifier, "Earth 2.0", "Exoplanet identifier should match mock data")
    }

    func test_fetchExoplanets_withDataSourceFailure_shouldRetry() async throws {
        let dataSource = MockExoplanetDataSource()
        dataSource.shouldThrowError = true

        let retryHandler = MockRetryableOperation()
        retryHandler.configuration.maxAttempts = 2

        let repository = RemoteExoplanetRepository(dataSource: dataSource, retryHandler: retryHandler)
        do {
            _ = try await repository.fetchExoplanets()
            XCTFail("Repository should throw an error after retry attempts")
        } catch {
            XCTAssertEqual(retryHandler.executeCount, 2, "Retry handler should attempt the operation twice")
        }
    }
}
