import Foundation

public protocol RetryConfiguration {
    var maxAttempts: Int { get set }
    var delayBetweenAttempts: TimeInterval { get set }
    func delay() async
}
