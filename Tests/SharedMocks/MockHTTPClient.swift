import Foundation
@testable import Data

final class MockHTTPClient: HTTPClient {
    var mockedData: Data?
    var shouldThrowError = false

    func get(from url: URL) async throws -> Data {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockedData ?? Data()
    }
}
