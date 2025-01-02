import Foundation
@testable import Data

final class MockRetryConfiguration: RetryConfiguration {
    var maxAttempts: Int = 1
    var delayBetweenAttempts: TimeInterval = 1.0
    func delay() async {

    }
}
