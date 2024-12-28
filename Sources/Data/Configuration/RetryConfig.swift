import Foundation

public struct RetryConfig {
    public let maxAttempts: Int
    public let delayBetweenAttempts: TimeInterval

    public init(maxAttempts: Int = 3, delayBetweenAttempts: TimeInterval = 1.0) {
        self.maxAttempts = maxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }
}
