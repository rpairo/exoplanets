import XCTest
@testable import Domain
@testable import Presentation
@testable import Data

final class ExoplanetPresenterTests: XCTestCase {
    func test_present_withSuccessfulResult_shouldReturnSuccess() async throws {
        let exoplanets = TestFactory.makeOrphanPlanets(count: 2)
        let result = TestFactory.makeProcessedResult(orphanPlanets: exoplanets)
        let (sut, _) = TestFactory.Unit.makePresenter(result: .success(result))
        let presentationResult = try await sut.present()

        if case .success(let processed) = presentationResult {
            XCTAssertEqual(processed.orphanPlanets?.count, 2)
        } else {
            XCTFail("Expected success result")
        }
    }

    func test_present_withError_shouldReturnFailure() async throws {
        let error = NSError(domain: "test", code: -1)
        let (sut, _) = TestFactory.Unit.makePresenter(result: .failure(error))
        let presentationResult = try await sut.present()

        if case .failure(let resultError) = presentationResult {
            XCTAssertEqual(resultError as NSError, error)
        } else {
            XCTFail("Expected failure result")
        }
    }

    func test_present_withOrphanPlanets_shouldUpdateView() async throws {
        let exoplanets = TestFactory.makeOrphanPlanets(count: 2)
        let result = TestFactory.makeProcessedResult(orphanPlanets: exoplanets)
        let (sut, view) = TestFactory.Unit.makePresenter(result: .success(result))
        _ = try await sut.present()

        XCTAssertEqual(view.displayOrphanPlanetsCallCount, 1)
        XCTAssertEqual(view.lastOrphanPlanetsData?.count, 2)
        XCTAssertEqual(view.lastOrphanPlanetsData?.identifiers, ["Orphan0", "Orphan1"])
    }

    func test_present_withHottestStar_shouldUpdateView() async throws {
        let hotPlanet = TestFactory.makeExoplanet(identifier: "Hot", hostStarTempK: 10000)
        let result = TestFactory.makeProcessedResult(hottestStarExoplanet: hotPlanet)
        let (sut, view) = TestFactory.Unit.makePresenter(result: .success(result))
        _ = try await sut.present()

        XCTAssertEqual(view.displayHottestStarCallCount, 1)
        XCTAssertEqual(view.lastHottestStarData?.identifier, "Hot")
        XCTAssertEqual(view.lastHottestStarData?.temperature, 10000)
    }

    func test_present_withTimeline_shouldUpdateView() async throws {
        let timeline: [Int: PlanetSizeCount] = [
            2000: PlanetSizeCount(small: 1, medium: 2, large: 3)
        ]
        let result = TestFactory.makeProcessedResult(timeline: timeline)
        let (sut, view) = TestFactory.Unit.makePresenter(result: .success(result))
        _ = try await sut.present()

        XCTAssertEqual(view.displayTimelineCallCount, 1)
        XCTAssertNotNil(view.lastTimelineData)
    }

    func test_present_withNetworkError_shouldDisplayError() async throws {
        let error = NetworkError.badStatus(404)
        let (sut, view) = TestFactory.Unit.makePresenter(result: .failure(error))
        let presentationResult = try await sut.present()

        if case .failure(let resultError) = presentationResult {
            XCTAssertEqual(resultError as? NetworkError, error)
            XCTAssertEqual(view.displayErrorCallCount, 1)
            XCTAssertEqual(view.lastErrorMessage, "The server returned an error status: 404")
        } else {
            XCTFail("Expected failure result")
        }
    }

    func test_present_withCompleteData_shouldUpdateAllViewComponents() async throws {
        let orphans = TestFactory.makeOrphanPlanets(count: 2)
        let hotPlanet = TestFactory.makeExoplanet(identifier: "Hot", hostStarTempK: 10000)
        let timeline = [2000: PlanetSizeCount(small: 1, medium: 2, large: 3)]
        let result = TestFactory.makeProcessedResult(
            orphanPlanets: orphans,
            timeline: timeline,
            hottestStarExoplanet: hotPlanet
        )
        let (sut, view) = TestFactory.Unit.makePresenter(result: .success(result))
        _ = try await sut.present()

        XCTAssertEqual(view.displayOrphanPlanetsCallCount, 1)
        XCTAssertEqual(view.displayHottestStarCallCount, 1)
        XCTAssertEqual(view.displayTimelineCallCount, 1)
        XCTAssertEqual(view.displayErrorCallCount, 0)
    }
}
