@testable import Presentation
@testable import Domain

final class MockPresenter: ExoplanetPresenting {
    var orphanPlanetsResult: [Exoplanet]? = nil
    var hottestStarExoplanetResult: Exoplanet? = nil
    var timelineResult: YearlyPlanetSizeDistribution? = nil

    func orphanPlanets() -> [Exoplanet]? { orphanPlanetsResult }
    func hottestStarExoplanet() -> Exoplanet? { hottestStarExoplanetResult }
    func timeline() -> YearlyPlanetSizeDistribution? { timelineResult }
}
