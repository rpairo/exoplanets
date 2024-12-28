import Foundation
import Domain

public protocol ExoplanetPresenting {
    func present() async throws -> PresentationResult
}

public enum PresentationResult {
    case success(ProcessedExoplanetResult)
    case failure(Error)
}
