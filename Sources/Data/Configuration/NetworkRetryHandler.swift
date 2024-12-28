import Foundation

public struct NetworkRetryHandler: RetryableOperation {
    private let config: RetryConfig

    public init(config: RetryConfig) {
        self.config = config
    }

    public func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T {
        var lastError: Error?

        for attempt in 1...config.maxAttempts {
            do {
                return try await operation()
            } catch {
                lastError = error
                if attempt < config.maxAttempts {
                    try await Task.sleep(nanoseconds: UInt64(config.delayBetweenAttempts * 1_000_000_000))
                }
            }
        }

        throw lastError ?? NetworkError.unableToComplete
    }
}
