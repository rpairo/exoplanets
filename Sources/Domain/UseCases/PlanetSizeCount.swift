public struct PlanetSizeCount: Equatable {
    public let small: Int
    public let medium: Int
    public let large: Int

    public static var zero: PlanetSizeCount {
        .init(small: 0, medium: 0, large: 0)
    }

    public func adding(_ other: PlanetSizeCount) -> PlanetSizeCount {
        .init(
            small: self.small + other.small,
            medium: self.medium + other.medium,
            large: self.large + other.large
        )
    }

    public static func == (lhs: PlanetSizeCount, rhs: PlanetSizeCount) -> Bool {
        lhs.small == rhs.small &&
        lhs.medium == rhs.medium &&
        lhs.large == rhs.large
    }
}
