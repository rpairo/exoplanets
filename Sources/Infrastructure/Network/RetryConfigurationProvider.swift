import Foundation
import Data

public struct RetryConfigurationProvider: RetryConfiguration {
    public var maxAttempts: Int
    public var delayBetweenAttempts: TimeInterval

    public init(maxAttempts: Int, delayBetweenAttempts: TimeInterval) {
        self.maxAttempts = maxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }

    public func delay() async {
        try? await Task.sleep(nanoseconds: UInt64(delayBetweenAttempts * 1_000_000_000))
    }
}
