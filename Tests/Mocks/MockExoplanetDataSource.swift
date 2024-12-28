import XCTest
@testable import Domain
@testable import Data

final class MockExoplanetDataSource: ExoplanetDataSource {
    private(set) var fetchCallCount = 0
    private(set) var lastFetchCall: Date?
    private let result: Result<[Exoplanet], Error>
    private let successAfterAttempts: Int?
    private let exoplanetsAfterRetry: [Exoplanet]?

    init(result: Result<[Exoplanet], Error>) {
        self.result = result
        self.successAfterAttempts = nil
        self.exoplanetsAfterRetry = nil
    }

    init(
        failingAttempts: Int,
        initialError: Error = NetworkError.badStatus(500),
        eventualSuccess: [Exoplanet]
    ) {
        self.result = .failure(initialError)
        self.successAfterAttempts = failingAttempts
        self.exoplanetsAfterRetry = eventualSuccess
    }

    func fetch() async throws -> [Exoplanet] {
        fetchCallCount += 1
        lastFetchCall = Date()

        if let successAfterAttempts, let exoplanetsAfterRetry {
            if fetchCallCount <= successAfterAttempts {
                if case .failure(let error) = result {
                    throw error
                }
            }
            return exoplanetsAfterRetry
        }

        switch result {
        case .success(let exoplanets):
            return exoplanets
        case .failure(let error):
            throw error
        }
    }
}
