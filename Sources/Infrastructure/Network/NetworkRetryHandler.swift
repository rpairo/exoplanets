import Foundation
import Data

public class NetworkRetryHandler: RetryableOperation {
    private let configuration: RetryConfiguration

    public init(configuration: RetryConfiguration) {
        self.configuration = configuration
    }

    public func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T {
        var lastError: Error?
        for attempt in 1...configuration.maxAttempts {
            do {
                return try await operation()
            } catch {
                lastError = error
                if attempt < configuration.maxAttempts {
                    await configuration.delay()
                }
            }
        }
        throw lastError ?? NetworkError.unableToComplete
    }
}
