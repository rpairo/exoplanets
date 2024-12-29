import Foundation

public protocol RetryConfiguration {
    var maxAttempts: Int { get }
    var delayBetweenAttempts: TimeInterval { get }
    func delay() async
}
