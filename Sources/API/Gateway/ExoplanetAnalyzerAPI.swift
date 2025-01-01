import Presentation
import Composition
import Domain

public struct ExoplanetAnalyzerAPI: ExoplanetAnalyzerAPIProtocol {
    private let presenter: ExoplanetPresenting

    public init(presenter: ExoplanetPresenting) {
        self.presenter = presenter
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

public extension ExoplanetAnalyzerAPI {
    static func makeDefault() async throws -> ExoplanetAnalyzerAPI {
        let appComposition: ApplicationBuilder = AppComposition()
        try await appComposition.build()
        let presenter: ExoplanetPresenting = try DIContainer.shared.resolve()
        return ExoplanetAnalyzerAPI(presenter: presenter)
    }
}
