import Foundation
@testable import Domain
@testable import Presentation

final class MockExoplanetPresenter: ExoplanetPresenting {
    private(set) var presentCallCount = 0
    private(set) var lastPresentCall: Date?
    private let result: Result<ProcessedExoplanetResult, Error>

    init(result: Result<ProcessedExoplanetResult, Error>) {
        self.result = result
    }

    func present() async throws -> PresentationResult {
        presentCallCount += 1
        lastPresentCall = Date()

        switch result {
        case .success(let processedResult):
            return .success(processedResult)
        case .failure(let error):
            return .failure(error)
        }
    }
}
