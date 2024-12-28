import XCTest
@testable import Domain

final class ExoplanetUseCaseTests: XCTestCase {
    func test_processExoplanets_withOrphanPlanets_shouldReturnCorrectCount() async throws {
        let result = ProcessedExoplanetResult(
            orphanPlanets: TestFactory.makeOrphanPlanets(count: 2),
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertEqual(processed.orphanPlanets?.count, 2)
        XCTAssertEqual(processed.orphanPlanets?.map { $0.planetIdentifier }, ["Orphan0", "Orphan1"])
    }

    func test_processExoplanets_withNoOrphanPlanets_shouldReturnNil() async throws {
        let regularPlanets = [
            TestFactory.makeExoplanet(identifier: "Regular1", typeFlag: 0),
            TestFactory.makeExoplanet(identifier: "Regular2", typeFlag: 1)
        ]
        let result = ProcessedExoplanetResult(
            orphanPlanets: regularPlanets,
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.orphanPlanets)
    }

    func test_processExoplanets_withHottestStar_shouldReturnCorrectPlanet() async throws {
        let hotPlanet = TestFactory.makeExoplanet(identifier: "Hot", hostStarTempK: 10000)
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: hotPlanet
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertEqual(processed.hottestStarExoplanet?.planetIdentifier, "Hot")
        XCTAssertEqual(processed.hottestStarExoplanet?.hostStarTempK, 10000)
    }

    func test_processExoplanets_withNoTemperatureData_shouldReturnNilHottestStar() async throws {
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.hottestStarExoplanet)
    }

    func test_processExoplanets_withSizeData_shouldReturnCorrectTimeline() async throws {
        let timeline: [Int: PlanetSizeCount] = [
            2000: PlanetSizeCount(small: 1, medium: 2, large: 3)
        ]
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: timeline,
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertEqual(processed.timeline?[2000]?.small, 1)
        XCTAssertEqual(processed.timeline?[2000]?.medium, 2)
        XCTAssertEqual(processed.timeline?[2000]?.large, 3)
    }

    func test_processExoplanets_withNoSizeData_shouldReturnNilTimeline() async throws {
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.timeline)
    }

    func test_processExoplanets_whenRepositoryFails_shouldPropagateError() async {
        let expectedError = NSError(domain: "test", code: -1)
        let sut = TestFactory.Unit.makeUseCase(result: .failure(expectedError))

        do {
            _ = try await sut.processExoplanets()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

    func test_processExoplanets_withCompleteData_shouldReturnAllComponents() async throws {
        let orphans = TestFactory.makeOrphanPlanets(count: 2)
        let hotPlanet = TestFactory.makeExoplanet(identifier: "Hot", hostStarTempK: 10000)
        let timeline: [Int: PlanetSizeCount] = [
            2000: PlanetSizeCount(small: 1, medium: 2, large: 3)
        ]
        let result = ProcessedExoplanetResult(
            orphanPlanets: orphans,
            timeline: timeline,
            hottestStarExoplanet: hotPlanet
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertEqual(processed.orphanPlanets?.count, 2)
        XCTAssertEqual(processed.hottestStarExoplanet?.planetIdentifier, "Hot")
        XCTAssertNotNil(processed.timeline)
    }

    func test_processExoplanets_withEmptyData_shouldReturnNilResults() async throws {
        let result = ProcessedExoplanetResult(orphanPlanets: [], timeline: [:], hottestStarExoplanet: nil)
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.orphanPlanets)
        XCTAssertNil(processed.timeline)
        XCTAssertNil(processed.hottestStarExoplanet)
    }

    func test_processExoplanets_withAllNullValues_shouldHandleGracefully() async throws {
        let exoplanet = TestFactory.makeExoplanet()
        let result = ProcessedExoplanetResult(
            orphanPlanets: [exoplanet],
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.timeline)
        XCTAssertNotNil(processed.orphanPlanets)
        XCTAssertNil(processed.hottestStarExoplanet)
    }

    func test_processExoplanets_withExtremeIntegerValues() async throws {
        let exoplanet = TestFactory.makeExoplanet(
            typeFlag: .max,
            discoveryYear: .max,
            hostStarTempK: .max
        )
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: exoplanet
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.orphanPlanets)
        XCTAssertNil(processed.timeline)
        XCTAssertEqual(processed.hottestStarExoplanet?.hostStarTempK, Int.max)
    }

    func test_processExoplanets_withExtremeDoubleValues() async throws {
        let exoplanet = TestFactory.makeExoplanet(
            radiusJpt: .greatestFiniteMagnitude,
            discoveryYear: 2000
        )
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [2000: PlanetSizeCount(small: 0, medium: 0, large: 1)],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.orphanPlanets)
        XCTAssertEqual(processed.timeline?[2000]?.large, 1)
        XCTAssertNil(processed.hottestStarExoplanet)
    }

    func test_processExoplanets_withSpecialCharactersInIdentifier() async throws {
        let identifier = "Planet with special chars: áéíóú!@#$%^&*()"
        let exoplanet = TestFactory.makeExoplanet(
            identifier: identifier,
            typeFlag: 3
        )
        let result = ProcessedExoplanetResult(
            orphanPlanets: [exoplanet],
            timeline: [:],
            hottestStarExoplanet: nil
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertEqual(processed.orphanPlanets?.count, 1)
        XCTAssertEqual(processed.orphanPlanets?.first?.planetIdentifier, identifier)
    }

    func test_processExoplanets_withNegativeValues() async throws {
        let exoplanet = TestFactory.makeExoplanet(
            radiusJpt: -1.0,
            hostStarTempK: -5000
        )
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: exoplanet
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.timeline)
        XCTAssertNil(processed.orphanPlanets)
        XCTAssertNotNil(processed.hottestStarExoplanet)
    }

    func test_processExoplanets_withZeroValues() async throws {
        let exoplanet = TestFactory.makeExoplanet(
            radiusJpt: 0.0,
            hostStarTempK: 0
        )
        let result = ProcessedExoplanetResult(
            orphanPlanets: [],
            timeline: [:],
            hottestStarExoplanet: exoplanet
        )
        let sut = TestFactory.Unit.makeUseCase(result: .success(result))
        let processed = try await sut.processExoplanets()

        XCTAssertNil(processed.timeline)
        XCTAssertNil(processed.orphanPlanets)
        XCTAssertEqual(processed.hottestStarExoplanet?.hostStarTempK, 0)
    }
}
