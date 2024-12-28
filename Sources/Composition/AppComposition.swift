import Data
import Foundation
import Domain
import Infrastructure
import Presentation
import Configuration

public struct AppComposition: ApplicationFlow {
    private let container = DIContainer.shared

    public init() {}

    public func build(for environment: Environment) {
        container.reset()

        registerConfiguration(for: environment)
        registerNetworking()
        registerDataLayer()
        registerDomainLayer()
        registerPresentationLayer()
    }

    private func registerConfiguration(for environment: Environment) {
        container.register(EnvironmentConfigurationProvider(environment: environment), for: AppConfigurationProvider.self)
    }

    private func registerNetworking() {
        container.register(URLSessionHTTPClient(), for: HTTPClient.self)
    }

    private func registerDataLayer() {
        let configProvider: AppConfigurationProvider = container.resolve()
        let config = configProvider.provideConfiguration()
        guard let url = URL(string: config.apiURL) else {
            fatalError("Invalid URL in configuration")
        }

        container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)
        container.register(ExoplanetRepositoryImpl(dataSource: container.resolve()), for: ExoplanetRepository.self)
    }

    private func registerDomainLayer() {
        container.register(ExoplanetUseCase(repository: container.resolve()), for: ExoplanetProcessing.self)
    }

    private func registerPresentationLayer() {
        container.register(ConsoleView(), for: ExoplanetView.self)
        container.register(ExoplanetPresenter(useCases: container.resolve(), view: container.resolve()), for: ExoplanetPresenting.self)
    }

    public func start() async throws {
        let presenter: ExoplanetPresenting = container.resolve()
        _ = try await presenter.present()
    }
}
