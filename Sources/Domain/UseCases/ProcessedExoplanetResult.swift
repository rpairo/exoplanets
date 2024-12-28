public typealias YearlyPlanetSizeDistribution = [Int: PlanetSizeCount]

public struct ProcessedExoplanetResult {
    public let orphanPlanets: [Exoplanet]?
    public let timeline: YearlyPlanetSizeDistribution?
    public let hottestStarExoplanet: Exoplanet?

    init(orphanPlanets: [Exoplanet], timeline: YearlyPlanetSizeDistribution, hottestStarExoplanet: Exoplanet?) {
        self.orphanPlanets = orphanPlanets.isEmpty ? nil : orphanPlanets
        self.timeline = timeline.isEmpty ? nil : timeline
        self.hottestStarExoplanet = hottestStarExoplanet
    }
}
