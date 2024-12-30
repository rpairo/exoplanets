public typealias YearlyPlanetSizeDistributionDTO = [Int: PlanetSizeCountDTO]

public protocol ExoplanetAnalyzerAPIProtocol {
    func getOrphanPlanets() -> [ExoplanetDTO]?
    func getHottestStarExoplanet() -> ExoplanetDTO?
    func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO?
}
