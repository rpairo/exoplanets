import Foundation

public struct RetryConfigurationProvider: RetryConfiguration {
    public let maxAttempts: Int
    public let delayBetweenAttempts: TimeInterval

    public init(maxAttempts: Int, delayBetweenAttempts: TimeInterval) {
        self.maxAttempts = maxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }

    public func delay() async {
        try? await Task.sleep(nanoseconds: UInt64(delayBetweenAttempts * 1_000_000_000))
    }
}
