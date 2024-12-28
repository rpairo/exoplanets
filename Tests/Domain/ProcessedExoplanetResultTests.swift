import XCTest
@testable import Domain

final class ProcessedExoplanetResultTests: XCTestCase {
    func test_init_withEmptyCollections_shouldReturnNilProperties() {
        let sut = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: nil
        )

        XCTAssertNil(sut.orphanPlanets)
        XCTAssertNil(sut.timeline)
        XCTAssertNil(sut.hottestStarExoplanet)
    }

    func test_init_withValidData_shouldInitializeCorrectly() {
        let exoplanet = TestFactory.makeExoplanet(identifier: "Test", typeFlag: 3)
        let timeline: YearlyPlanetSizeDistribution = [2000: PlanetSizeCount(small: 1, medium: 0, large: 0)]
        let sut = ProcessedExoplanetResult(
            orphanPlanets: [exoplanet],
            timeline: timeline,
            hottestStarExoplanet: exoplanet
        )

        XCTAssertEqual(sut.orphanPlanets?.count, 1)
        XCTAssertEqual(sut.orphanPlanets?.first?.planetIdentifier, "Test")
        XCTAssertNotNil(sut.timeline)
        XCTAssertEqual(sut.timeline?[2000]?.small, 1)
        XCTAssertEqual(sut.hottestStarExoplanet?.planetIdentifier, "Test")
    }

    func test_init_withPartialData_shouldInitializeCorrectly() {
        let exoplanet = TestFactory.makeExoplanet(identifier: "Test")
        let timeline: YearlyPlanetSizeDistribution = [2000: PlanetSizeCount(small: 1, medium: 0, large: 0)]
        let sut = ProcessedExoplanetResult(
            orphanPlanets: [exoplanet],
            timeline: timeline,
            hottestStarExoplanet: nil
        )

        XCTAssertEqual(sut.orphanPlanets?.count, 1)
        XCTAssertNotNil(sut.timeline)
        XCTAssertNil(sut.hottestStarExoplanet)
    }

    func test_init_withEmptyTimeline_shouldReturnNilTimeline() {
        let exoplanet = TestFactory.makeExoplanet(identifier: "Test")
        let sut = ProcessedExoplanetResult(
            orphanPlanets: [exoplanet],
            timeline: [:],
            hottestStarExoplanet: exoplanet
        )

        XCTAssertNotNil(sut.orphanPlanets)
        XCTAssertNil(sut.timeline)
        XCTAssertNotNil(sut.hottestStarExoplanet)
    }

    func test_init_withEmptyOrphanPlanets_shouldReturnNilOrphanPlanets() {
        let exoplanet = TestFactory.makeExoplanet(identifier: "Test")
        let timeline: YearlyPlanetSizeDistribution = [2000: PlanetSizeCount(small: 1, medium: 0, large: 0)]
        let sut = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: timeline,
            hottestStarExoplanet: exoplanet
        )

        XCTAssertNil(sut.orphanPlanets)
        XCTAssertNotNil(sut.timeline)
        XCTAssertNotNil(sut.hottestStarExoplanet)
    }
}
