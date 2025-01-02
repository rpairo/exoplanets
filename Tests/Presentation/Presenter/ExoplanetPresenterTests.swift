import XCTest
@testable import Presentation
@testable import Domain

final class ExoplanetPresenterTests: XCTestCase {
    // MARK: - Tests
    func test_presenter_initialization_withValidUseCase_shouldPrepareData() async throws {
        let mockUseCase = MockExoplanetProcessing()
        let presenter = try await ExoplanetPresenter(useCases: mockUseCase)

        XCTAssertNotNil(presenter.orphanPlanets(), "Orphan planets should not be nil")
        XCTAssertNotNil(presenter.hottestStarExoplanet(), "Hottest star exoplanet should not be nil")
        XCTAssertNotNil(presenter.timeline(), "Timeline should not be nil")
    }

    func test_presenter_accessors_shouldReturnCorrectData() async throws {
        let mockUseCase = MockExoplanetProcessing()
        let presenter = try await ExoplanetPresenter(useCases: mockUseCase)

        XCTAssertEqual(presenter.orphanPlanets()?.first?.planetIdentifier, "OrphanPlanet", "Orphan planet identifier should match mock data")
        XCTAssertEqual(presenter.hottestStarExoplanet()?.planetIdentifier, "HotStarPlanet", "Hottest star planet identifier should match mock data")
        XCTAssertEqual(presenter.timeline()?[2022]?.medium, 2, "Medium planets in 2022 should match mock data")
    }

    func test_presenter_initialization_withUseCaseError_shouldThrowError() async {
        let mockUseCase = MockExoplanetProcessing()
        mockUseCase.shouldThrowError = true

        do {
            _ = try await ExoplanetPresenter(useCases: mockUseCase)
            XCTFail("Presenter initialization should throw an error when use case fails")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }
}
