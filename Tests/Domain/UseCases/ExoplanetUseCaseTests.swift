import XCTest
@testable import Domain

final class ExoplanetUseCaseTests: XCTestCase {
    // MARK: - Mock Repository
    final class MockExoplanetRepository: ExoplanetRepository {
        var mockedExoplanets: [Exoplanet] = []
        var shouldThrowError: Bool = false

        func fetchExoplanets() async throws -> [Exoplanet] {
            if shouldThrowError {
                throw NSError(domain: "Test", code: 1, userInfo: nil)
            }
            return mockedExoplanets
        }
    }

    // MARK: - Tests
    func test_processExoplanets_withValidData_shouldGenerateCorrectResults() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: 0.5, periodDays: nil, semiMajorAxisAU: nil, eccentricity: nil, periastronDeg: nil, longitudeDeg: nil, ascendingNodeDeg: nil, inclinationDeg: nil, surfaceTempK: nil, ageGyr: nil, discoveryMethod: nil, discoveryYear: 2020, lastUpdated: nil, rightAscension: nil, declination: nil, distFromSunParsec: nil, hostStarMassSlrMass: nil, hostStarRadiusSlrRad: nil, hostStarMetallicity: nil, hostStarTempK: 5000, hostStarAgeGyr: nil),
            Exoplanet(planetIdentifier: "PlanetB", typeFlag: 3, planetaryMassJpt: nil, radiusJpt: 2.0, periodDays: nil, semiMajorAxisAU: nil, eccentricity: nil, periastronDeg: nil, longitudeDeg: nil, ascendingNodeDeg: nil, inclinationDeg: nil, surfaceTempK: nil, ageGyr: nil, discoveryMethod: nil, discoveryYear: 2021, lastUpdated: nil, rightAscension: nil, declination: nil, distFromSunParsec: nil, hostStarMassSlrMass: nil, hostStarRadiusSlrRad: nil, hostStarMetallicity: nil, hostStarTempK: 6000, hostStarAgeGyr: nil)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertEqual(result.orphanPlanets?.count, 1, "There should be 1 orphan planet")
        XCTAssertEqual(result.timeline?.count, 2, "Timeline should contain 2 years")
        XCTAssertEqual(result.hottestStarExoplanet?.planetIdentifier, "PlanetB", "Hottest star exoplanet should be PlanetB")
    }

    func test_processExoplanets_withRepositoryError_shouldThrowError() async {
        let mockRepository = MockExoplanetRepository()
        mockRepository.shouldThrowError = true

        let useCase = ExoplanetUseCase(repository: mockRepository)

        do {
            _ = try await useCase.processExoplanets()
            XCTFail("Processing should throw an error when repository fails")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }

    func test_processExoplanets_withEmptyData_shouldReturnNilResults() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = []

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertNil(result.orphanPlanets?.count, "There should be no orphan planets for empty data")
        XCTAssertNil(result.timeline?.count, "Timeline should be empty for no exoplanets")
        XCTAssertNil(result.hottestStarExoplanet, "Hottest star exoplanet should be nil for empty data")
    }

    func test_processExoplanets_withMixedTypeFlags_shouldCategorizeCorrectly() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: 0, discoveryYear: 2020, hostStarTempK: 4000),
            Exoplanet(planetIdentifier: "PlanetB", typeFlag: 3, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2021, hostStarTempK: nil),
            Exoplanet(planetIdentifier: "PlanetC", typeFlag: 2, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2021, hostStarTempK: 5000)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertEqual(result.orphanPlanets?.count, 1, "There should be 1 orphan planet with typeFlag 3")
        XCTAssertEqual(result.timeline?[2020]?.small, 1, "2020 should have 1 small planet")
        XCTAssertEqual(result.hottestStarExoplanet?.planetIdentifier, "PlanetC", "Hottest star exoplanet should be PlanetC")
    }

    func test_processExoplanets_withMultipleHottestStarCandidates_shouldChooseCorrectly() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetX", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2020, hostStarTempK: 7000),
            Exoplanet(planetIdentifier: "PlanetY", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2020, hostStarTempK: 8000),
            Exoplanet(planetIdentifier: "PlanetZ", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2020, hostStarTempK: 6000)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertEqual(result.hottestStarExoplanet?.planetIdentifier, "PlanetY", "Hottest star exoplanet should be PlanetY with the highest temperature")
    }

    func test_processExoplanets_withInvalidDiscoveryYears_shouldIgnoreThem() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: nil, hostStarTempK: 5000),
            Exoplanet(planetIdentifier: "PlanetB", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: 0, discoveryYear: 2021, hostStarTempK: 6000)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertEqual(result.timeline?.count, 1, "Timeline should include only valid discovery years")
        XCTAssertEqual(result.timeline?[2021]?.small, 1, "2021 should have 1 small planet")
    }

    func test_processExoplanets_withNoHottestStarExoplanet_shouldReturnNil() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: 3, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: 2020, hostStarTempK: nil)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertNil(result.hottestStarExoplanet, "Hottest star exoplanet should be nil if no valid candidates exist")
    }

    func test_processExoplanets_withNotRequiredData_shouldBeDiscarted() async throws {
        // Arrange
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: nil, planetaryMassJpt: nil, radiusJpt: nil, discoveryYear: nil, hostStarTempK: nil)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertNil(result.orphanPlanets?.count, "Orphan planets should not include entries with partial data")
        XCTAssertNil(result.hottestStarExoplanet, "Hottest star exoplanet should be nil for incomplete data")
        XCTAssertNil(result.timeline?.count, "Timeline should be empty for incomplete data")
    }

    func test_processExoplanets_withSameDiscoveryYear_shouldIncreaseCounterOfSameYear() async throws {
        let mockRepository = MockExoplanetRepository()
        mockRepository.mockedExoplanets = [
            Exoplanet(planetIdentifier: "PlanetA", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: 0, discoveryYear: 2020, hostStarTempK: 4000),
            Exoplanet(planetIdentifier: "PlanetB", typeFlag: 1, planetaryMassJpt: nil, radiusJpt: 0, discoveryYear: 2020, hostStarTempK: 4000)
        ]

        let useCase = ExoplanetUseCase(repository: mockRepository)
        let result = try await useCase.processExoplanets()

        XCTAssertEqual(result.timeline?.count, 1, "Timeline should include each year only once")
        XCTAssertEqual(result.timeline?[2020]?.small, 2, "2020 should include both the planets")
    }
}
