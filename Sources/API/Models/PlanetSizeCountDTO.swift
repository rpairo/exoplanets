@_exported import Domain

public struct PlanetSizeCountDTO: Codable, Equatable {
    public let smallPlanets: Int
    public let mediumPlanets: Int
    public let largePlanets: Int

    public init(smallPlanets: Int, mediumPlanets: Int, largePlanets: Int) {
        self.smallPlanets = smallPlanets
        self.mediumPlanets = mediumPlanets
        self.largePlanets = largePlanets
    }

    public static func from(domain: PlanetSizeCount) -> PlanetSizeCountDTO {
        return PlanetSizeCountDTO(
            smallPlanets: domain.small,
            mediumPlanets: domain.medium,
            largePlanets: domain.large
        )
    }
}
