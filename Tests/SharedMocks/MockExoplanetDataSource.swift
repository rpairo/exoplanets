import Foundation
@testable import Data
@testable import Domain

final class MockExoplanetDataSource: ExoplanetDataSource {
    var shouldThrowError = false
    var mockedExoplanets: [Exoplanet] = []

    func fetch() async throws -> [Exoplanet] {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockedExoplanets
    }
}
