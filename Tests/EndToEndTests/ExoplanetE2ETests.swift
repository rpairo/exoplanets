import XCTest
@testable import ExoplanetsAPI

final class ExoplanetE2ETests: XCTestCase {
    func test_endToEnd_withRealData_shouldProduceExpectedResults() async throws {
        // Fetch Data
        let api = try await ExoplanetAnalyzerAPI.makeDefault()
        let orphanPlanets = api.getOrphanPlanets()
        let hottestStar = api.getHottestStarExoplanet()
        let discoveryTimeline = api.getDiscoveryTimeline()

        // Assertions
        XCTAssertEqual(orphanPlanets?.count, 2, "There should be 2 orphan planets")
        XCTAssertEqual(orphanPlanets?.map { $0.planetIdentifier }, ["PSO J318.5-22", "CFBDSIR2149"], "Orphan planets should match expected")

        XCTAssertEqual(hottestStar?.planetIdentifier, "V391 Peg b", "Hottest star planet should be 'V391 Peg b'")
        XCTAssertEqual(hottestStar?.hostStarTempK, 29300, "Hottest star temperature should be 29300K")

        XCTAssertEqual(discoveryTimeline?[1781]?.small, 1, "1781 should have 1 small planet")
        XCTAssertEqual(discoveryTimeline?[2014]?.small, 830, "2014 should have 830 small planets")
    }
}
