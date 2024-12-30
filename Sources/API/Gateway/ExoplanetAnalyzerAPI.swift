import Foundation
import Presentation
import Composition
import Domain

public struct ExoplanetAnalyzerAPI: ExoplanetAnalyzerAPIProtocol {
    private var presenter: ExoplanetPresenting

    public init() async throws {
        let appComposition: ApplicationBuilder = AppComposition()
        try await appComposition.build()
        self.presenter = try DIContainer.shared.resolve()
    }

    public func getOrphanPlanets() -> [ExoplanetDTO]? {
        guard let planets = presenter.orphanPlanets() else { return nil }
        return planets.map { ExoplanetMapper.toDTO(from: $0) }
    }

    public func getHottestStarExoplanet() -> ExoplanetDTO? {
        guard let exoplanet = presenter.hottestStarExoplanet() else { return nil }
        return ExoplanetMapper.toDTO(from: exoplanet)
    }

    public func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO? {
        guard let timeline = presenter.timeline() else { return nil }
        return timeline.reduce(into: [:]) { result, planetSizeCount in
            result[planetSizeCount.key] = PlanetSizeCountDTO.from(domain: planetSizeCount.value)
        }
    }
}
