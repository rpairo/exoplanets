import Foundation
@testable import Domain

final class MockExoplanetProcessing: ExoplanetProcessing {
    var shouldThrowError = false
    var mockedResult: ProcessedExoplanetResult? = ProcessedExoplanetResult(
        orphanPlanets: [Exoplanet(planetIdentifier: "OrphanPlanet", typeFlag: 3, radiusJpt: 2.0)],
        timeline: [2022: PlanetSizeCount(small: 1, medium: 2, large: 3)],
        hottestStarExoplanet: Exoplanet(planetIdentifier: "HotStarPlanet", typeFlag: 1, radiusJpt: 1.0)
    )
    func processExoplanets() async throws -> ProcessedExoplanetResult {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockedResult!
    }
}
