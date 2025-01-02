import Foundation
@testable import Domain

final class MockExoplanetRepository: ExoplanetRepository {
    var mockedExoplanets: [Exoplanet] = []
    var shouldThrowError: Bool = false

    func fetchExoplanets() async throws -> [Exoplanet] {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockedExoplanets
    }
}
