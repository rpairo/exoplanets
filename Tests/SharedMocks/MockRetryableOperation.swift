import Foundation
@testable import Data

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
