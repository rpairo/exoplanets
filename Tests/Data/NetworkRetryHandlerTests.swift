import XCTest
@testable import Data

final class NetworkRetryHandlerTests: XCTestCase {

    func test_execute_withImmediateSuccess_shouldNotRetry() async throws {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0.1)
        let sut = NetworkRetryHandler(config: config)
        var attempts = 0

        // When
        let result: String = try await sut.execute {
            attempts += 1
            return "Success"
        }

        // Then
        XCTAssertEqual(result, "Success")
        XCTAssertEqual(attempts, 1)
    }

    func test_execute_withEventualSuccess_shouldRetryUntilSuccess() async throws {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0.1)
        let sut = NetworkRetryHandler(config: config)
        var attempts = 0

        // When
        let result: String = try await sut.execute {
            attempts += 1
            if attempts < 2 {
                throw NetworkError.badStatus(500)
            }
            return "Success"
        }

        // Then
        XCTAssertEqual(result, "Success")
        XCTAssertEqual(attempts, 2)
    }

    func test_execute_withMaxRetries_shouldFail() async {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0.1)
        let sut = NetworkRetryHandler(config: config)
        var attempts = 0

        // When/Then
        do {
            _ = try await sut.execute {
                attempts += 1
                throw NetworkError.badStatus(500)
            }
            XCTFail("Expected error")
        } catch {
            XCTAssertEqual(attempts, config.maxAttempts)
        }
    }

    func test_execute_withDifferentErrors_shouldPropagateLastError() async {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0.1)
        let sut = NetworkRetryHandler(config: config)
        var attempts = 0

        // When/Then
        do {
            _ = try await sut.execute {
                attempts += 1
                switch attempts {
                case 1: throw NetworkError.badStatus(500)
                case 2: throw NetworkError.invalidResponse
                default: throw NetworkError.unableToComplete
                }
            }
        } catch let error as NetworkError {
            XCTAssertEqual(error, .unableToComplete)
            XCTAssertEqual(attempts, config.maxAttempts)
        } catch {
            XCTFail("Expected error")
        }
    }

    func test_execute_withZeroDelay_shouldRetryImmediately() async {
        // Given
        let config = RetryConfig(maxAttempts: 3, delayBetweenAttempts: 0)
        let sut = NetworkRetryHandler(config: config)
        var attempts = 0
        let startTime = Date()

        // When/Then
        do {
            _ = try await sut.execute {
                attempts += 1
                throw NetworkError.badStatus(500)
            }
            XCTFail("Expected error")
        } catch {
            let duration = Date().timeIntervalSince(startTime)
            XCTAssertEqual(attempts, config.maxAttempts)
            XCTAssertLessThan(duration, 0.1)
        }
    }
}
