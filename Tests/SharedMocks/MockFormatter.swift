@testable import Presentation
@testable import Domain

final class MockFormatter: TimelineFormatting {
    func format(_ timeline: YearlyPlanetSizeDistribution) -> (headers: String, separator: String, rows: [String]) {
        return ("Header", "-----", ["Row1", "Row2"])
    }
}
