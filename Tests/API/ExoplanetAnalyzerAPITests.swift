import XCTest
@testable import ExoplanetsAPI
@testable import Presentation
@testable import Domain
@testable import Composition

final class ExoplanetAnalyzerAPITests: XCTestCase {
    // MARK: - Mock Presenter
    final class MockPresenter: ExoplanetPresenting {
        var orphanPlanetsResult: [Exoplanet]?
        var hottestStarExoplanetResult: Exoplanet?
        var timelineResult: [Int: PlanetSizeCount]?

        func orphanPlanets() -> [Exoplanet]? {
            orphanPlanetsResult
        }

        func hottestStarExoplanet() -> Exoplanet? {
            hottestStarExoplanetResult
        }

        func timeline() -> [Int: PlanetSizeCount]? {
            timelineResult
        }
    }

    // MARK: - Tests

    func test_customInitialization_shouldUseInjectedPresenter() {
        // Arrange
        let mockPresenter = MockPresenter()

        // Act
        let api = ExoplanetAnalyzerAPI(presenter: mockPresenter)

        // Assert
        XCTAssertNotNil(api, "ExoplanetAnalyzerAPI should be initialized successfully with a custom presenter.")
    }

    func test_makeDefaultInitialization_shouldSucceed() async throws {
        // Arrange
        let injector = DIContainer.shared
        injector.reset()
        let appComposition = AppComposition(with: injector)
        try await appComposition.build()
        let presenter: ExoplanetPresenting = try injector.resolve()

        // Act
        let api = try await ExoplanetAnalyzerAPI.makeDefault()

        // Assert
        XCTAssertNotNil(api, "ExoplanetAnalyzerAPI should be initialized successfully with default composition.")
        XCTAssertNotNil(presenter, "Presenter should be resolved correctly in default initialization.")
    }

    func test_getOrphanPlanets_withValidData_shouldReturnDTOs() {
        // Arrange
        let mockPresenter = MockPresenter()
        mockPresenter.orphanPlanetsResult = [
            Exoplanet(planetIdentifier: "OrphanPlanetA", typeFlag: 3, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2020),
            Exoplanet(planetIdentifier: "OrphanPlanetB", typeFlag: 3, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2021)
        ]
        let api = ExoplanetAnalyzerAPI(presenter: mockPresenter)

        // Act
        let result = api.getOrphanPlanets()

        // Assert
        XCTAssertEqual(result?.count, 2, "Should return 2 DTOs for orphan planets.")
        XCTAssertEqual(result?.first?.planetIdentifier, "OrphanPlanetA", "First DTO identifier should be 'OrphanPlanetA'.")
    }

    func test_getHottestStarExoplanet_withValidData_shouldReturnDTO() {
        // Arrange
        let mockPresenter = MockPresenter()
        mockPresenter.hottestStarExoplanetResult = Exoplanet(planetIdentifier: "HotPlanet", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2022)
        let api = ExoplanetAnalyzerAPI(presenter: mockPresenter)

        // Act
        let result = api.getHottestStarExoplanet()

        // Assert
        XCTAssertNotNil(result, "Should return a DTO for the hottest star's exoplanet.")
        XCTAssertEqual(result?.planetIdentifier, "HotPlanet", "DTO identifier should be 'HotPlanet'.")
    }

    func test_getDiscoveryTimeline_withValidData_shouldReturnDTOs() {
        // Arrange
        let mockPresenter = MockPresenter()
        mockPresenter.timelineResult = [
            2020: PlanetSizeCount(small: 1, medium: 2, large: 3),
            2021: PlanetSizeCount(small: 4, medium: 5, large: 6)
        ]
        let api = ExoplanetAnalyzerAPI(presenter: mockPresenter)

        // Act
        let result = api.getDiscoveryTimeline()

        // Assert
        XCTAssertEqual(result?.count, 2, "Should return a timeline with 2 years.")
        XCTAssertEqual(result?[2020]?.small, 1, "Small planets count for 2020 should be 1.")
        XCTAssertEqual(result?[2021]?.large, 6, "Large planets count for 2021 should be 6.")
    }
}
