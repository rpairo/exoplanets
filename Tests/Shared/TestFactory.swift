import Foundation
@testable import Domain
@testable import Data
@testable import Presentation
@testable import Composition

final class TestFactory {
    // MARK: - Mocks
    enum Mock {
        static func makeMockDataSource(
            result: Result<[Exoplanet], Error>
        ) -> ExoplanetDataSource {
            MockExoplanetDataSource(result: result)
        }

        static func makeMockRepository(
            result: Result<[Exoplanet], Error>
        ) -> ExoplanetRepository {
            MockExoplanetRepository(result: result)
        }

        static func makeMockUseCase(
            result: Result<ProcessedExoplanetResult, Error>
        ) -> ExoplanetProcessing {
            MockExoplanetUseCase(result: result)
        }

        static func makeMockHTTPClient(
            result: Result<Data, Error>
        ) -> HTTPClient {
            MockHTTPClient(result: result)
        }
    }

    // MARK: - Unit Tests
    enum Unit {
        static func makeDataSource(
            result: Result<Data, Error>
        ) -> ExoplanetDataSource {
            let client = makeMockHTTPClient(result: result)
            let config = EnvironmentConfigurationProvider.create(for: .testing)
            guard let url = URL(string: config.apiURL) else {
                fatalError("Invalid URL in test configuration")
            }
            return RemoteExoplanetDataSource(client: client, url: url)
        }

        static func makeRepository(
            exoplanets: [Exoplanet],
            config: RetryConfig = .init()
        ) -> ExoplanetRepository {
            let dataSource = Mock.makeMockDataSource(result: .success(exoplanets))
            return ExoplanetRepositoryImpl(dataSource: dataSource, config: config)
        }

        static func makeRepository(
            error: Error,
            config: RetryConfig = .init()
        ) -> ExoplanetRepository {
            let dataSource = Mock.makeMockDataSource(result: .failure(error))
            return ExoplanetRepositoryImpl(dataSource: dataSource, config: config)
        }

        static func makeUseCase(
            exoplanets: [Exoplanet]
        ) -> ExoplanetProcessing {
            let repository = makeRepository(exoplanets: exoplanets)
            return ExoplanetUseCase(repository: repository)
        }

        static func makeUseCase(
            error: Error
        ) -> ExoplanetProcessing {
            let repository = makeRepository(error: error)
            return ExoplanetUseCase(repository: repository)
        }

        static func makePresenter(
            result: Result<ProcessedExoplanetResult, Error>
        ) -> (presenter: ExoplanetPresenting, view: MockExoplanetView) {
            let useCase = Mock.makeMockUseCase(result: result)
            let view = MockExoplanetView()
            let presenter = ExoplanetPresenter(useCases: useCase, view: view)
            return (presenter, view)
        }

        private static func makeMockHTTPClient(
            result: Result<Data, Error>
        ) -> HTTPClient {
            MockHTTPClient(result: result)
        }
    }

    // MARK: - Integration Tests
    enum Integration {
        static func makePresenter() -> (presenter: ExoplanetPresenting, view: ExoplanetView) {
            let useCase = makeUseCase()
            let view = ConsoleView()
            let presenter = ExoplanetPresenter(useCases: useCase, view: view)
            return (presenter, view)
        }

        static func makeUseCase() -> ExoplanetProcessing {
            let repository = makeRepository()
            return ExoplanetUseCase(repository: repository)
        }

        static func makeRepository() -> ExoplanetRepository {
            let dataSource = makeDataSource()
            return ExoplanetRepositoryImpl(dataSource: dataSource)
        }

        static func makeDataSource() -> ExoplanetDataSource {
            let client = makeHTTPClient()
            let config = EnvironmentConfigurationProvider.integrationTest
            guard let url = URL(string: config.apiURL) else {
                fatalError("Invalid URL in test configuration")
            }
            return RemoteExoplanetDataSource(client: client, url: url)
        }

        static func makeHTTPClient() -> HTTPClient {
            URLSessionHTTPClient()
        }
    }

    // MARK: - Helper Methods
    static func makeExoplanet(
        identifier: String = "Test Planet",
        typeFlag: Int? = nil,
        radiusJpt: Double? = nil,
        discoveryYear: Int? = nil,
        hostStarTempK: Int? = nil
    ) -> Exoplanet {
        Exoplanet(
            planetIdentifier: identifier,
            typeFlag: typeFlag,
            radiusJpt: radiusJpt,
            discoveryYear: discoveryYear,
            hostStarTempK: hostStarTempK
        )
    }

    static func makeOrphanPlanets(count: Int = 2) -> [Exoplanet] {
        (0..<count).map { index in
            makeExoplanet(
                identifier: "Orphan\(index)",
                typeFlag: 3,
                radiusJpt: 1.5,
                discoveryYear: 2000,
                hostStarTempK: 5000
            )
        }
    }

    static func makeProcessedResult(
        orphanPlanets: [Exoplanet] = [],
        timeline: [Int: PlanetSizeCount] = [:],
        hottestStarExoplanet: Exoplanet? = nil
    ) -> ProcessedExoplanetResult {
        ProcessedExoplanetResult(
            orphanPlanets: orphanPlanets,
            timeline: timeline,
            hottestStarExoplanet: hottestStarExoplanet
        )
    }
}
