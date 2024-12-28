import Data
import Foundation
import Domain
import Infrastructure
import Presentation
import Configuration

public struct AppComposition: ApplicationFlow {
    private let container = DIContainer.shared

    public init() {}

    public func build(for environment: Environment) throws {
        container.reset()

        try registerConfiguration(for: environment)
        try registerNetworking()
        try registerDataLayer()
        try registerDomainLayer()
        try registerPresentationLayer()
    }

    private func registerConfiguration(for environment: Environment) throws {
        try container.register(EnvironmentConfigurationProvider(environment: environment), for: AppConfigurationProvider.self)
    }

    private func registerNetworking() throws {
        try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
    }

    private func registerDataLayer() throws {
        let configProvider: AppConfigurationProvider = try container.resolve()
        let config = configProvider.provideConfiguration()
        guard let url = URL(string: config.apiURL) else {
            throw AppCompositionError.invalidConfigurationURL(config.apiURL)
        }

        try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)
        try container.register(ExoplanetRepositoryImpl(dataSource: container.resolve()), for: ExoplanetRepository.self)
    }

    private func registerDomainLayer() throws {
        try container.register(ExoplanetUseCase(repository: container.resolve()), for: ExoplanetProcessing.self)
    }

    private func registerPresentationLayer() throws {
        try container.register(ConsoleView(), for: ExoplanetView.self)
        try container.register(ExoplanetPresenter(useCases: container.resolve(), view: container.resolve()), for: ExoplanetPresenting.self)
    }

    public func start() async throws {
        let presenter: ExoplanetPresenting = try container.resolve()
        _ = try await presenter.present()
    }
}

enum AppCompositionError: Error {
    case invalidConfigurationURL(String)
}

extension AppCompositionError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidConfigurationURL(let url):
            return "The provided API URL '\(url)' is invalid."
        }
    }
}
