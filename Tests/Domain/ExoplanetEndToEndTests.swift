import XCTest
@testable import Domain
@testable import Data
@testable import Presentation
@testable import Composition

final class ExoplanetEndToEndTests: XCTestCase {
    func test_endToEnd_withSuccessfulFlow_shouldDisplayAndReturnResults() async throws {
        var output: [String] = []
        let view = ConsoleView { output.append($0) }
        let useCase = TestFactory.Integration.makeUseCase()
        let sut = ExoplanetPresenter(useCases: useCase, view: view)
        let result = try await sut.present()

        XCTAssertTrue(output.contains { $0.contains("1. Orphan Planets Found: 2") })
        XCTAssertTrue(output.contains { $0.contains("PSO J318.5-22") })
        XCTAssertTrue(output.contains { $0.contains("2. Hottest Star System:") })
        XCTAssertTrue(output.contains { $0.contains("3. Discovery Timeline:") })

        if case .success(let processed) = result {
            XCTAssertEqual(processed.orphanPlanets?.count, 2)
            XCTAssertNotNil(processed.timeline)
            XCTAssertNotNil(processed.hottestStarExoplanet)
        }
    }

    func test_endToEnd_withNetworkError_shouldDisplayAndReturnError() async throws {
        var output: [String] = []
        let view = ConsoleView { output.append($0) }
        let client = MockHTTPClient(result: .failure(NetworkError.badStatus(404)))
        let config = EnvironmentConfigurationProvider.create(for: .testing)
        guard let url = URL(string: config.apiURL) else {
            XCTFail("Invalid URL")
            return
        }
        let dataSource = RemoteExoplanetDataSource(client: client, url: url)
        let repository = ExoplanetRepositoryImpl(dataSource: dataSource)
        let useCase = ExoplanetUseCase(repository: repository)
        let sut = ExoplanetPresenter(useCases: useCase, view: view)
        let result = try await sut.present()

        XCTAssertTrue(output.contains { $0.contains("Error:") })
        if case .failure(let error) = result {
            XCTAssertEqual(error as? NetworkError, .badStatus(404))
        }
    }
}
