import Domain

public protocol TimelineFormatting {
    func format(_ timeline: YearlyPlanetSizeDistribution) -> (headers: String, separator: String, rows: [String])
}
