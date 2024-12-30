import Foundation
import Domain

public protocol ExoplanetPresenting {
    func orphanPlanets() -> [Exoplanet]?
    func hottestStarExoplanet() -> Exoplanet?
    func timeline() -> YearlyPlanetSizeDistribution?
}
