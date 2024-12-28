import XCTest
@testable import Domain

final class MockExoplanetRepository: ExoplanetRepository {
    private(set) var fetchExoplanetsCallCount = 0
    private(set) var lastFetchCall: Date?

    private let result: Result<[Exoplanet], Error>

    init(result: Result<[Exoplanet], Error>) {
        self.result = result
    }

    func fetchExoplanets() async throws -> [Exoplanet] {
        fetchExoplanetsCallCount += 1
        lastFetchCall = Date()

        switch result {
        case .success(let exoplanets):
            return exoplanets
        case .failure(let error):
            throw error
        }
    }
}
