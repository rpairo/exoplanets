@_exported import Domain

public struct PlanetSizeCountDTO: Codable, Equatable {
    public let small: Int
    public let medium: Int
    public let large: Int

    public init(small: Int, medium: Int, large: Int) {
        self.small = small
        self.medium = medium
        self.large = large
    }

    public static func from(domain: PlanetSizeCount) -> PlanetSizeCountDTO {
        return PlanetSizeCountDTO(
            small: domain.small,
            medium: domain.medium,
            large: domain.large
        )
    }
}
