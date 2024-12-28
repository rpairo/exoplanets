import XCTest
@testable import Domain

final class MockExoplanetUseCase: ExoplanetProcessing {
    private(set) var processCallCount = 0
    private(set) var lastProcessCall: Date?
    private let result: Result<ProcessedExoplanetResult, Error>

    init(result: Result<ProcessedExoplanetResult, Error>) {
        self.result = result
    }

    func processExoplanets() async throws -> ProcessedExoplanetResult {
        processCallCount += 1
        lastProcessCall = Date()

        switch result {
        case .success(let processedResult):
            return processedResult
        case .failure(let error):
            throw error
        }
    }
}
