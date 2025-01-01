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
}
