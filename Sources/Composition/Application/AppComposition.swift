import Data
import Foundation
import Domain
import Infrastructure
import Presentation

public struct AppComposition: ApplicationFlow {
    private let container = DIContainer.shared

    public init() {}

    public func build() throws {
        container.reset()

        try registerConfiguration()
        try registerNetworking()
        try registerDataLayer()
        try registerDomainLayer()
        try registerPresentationLayer()
    }

    private func registerConfiguration() throws {
        try container.register(ConfigurationProvider(), for: AppConfigurationProvider.self)
    }

    private func registerNetworking() throws {
        try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
    }

    private func registerDataLayer() throws {
        let configProvider: AppConfigurationProvider = try container.resolve()
        let config = try configProvider.provideConfiguration()
        guard let url = URL(string: config.apiURL) else {
            throw AppCompositionError.invalidConfigurationURL(config.apiURL)
        }
        try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)

        try container.register(
            RetryConfigurationProvider(
                maxAttempts: config.maxAttempts,
                delayBetweenAttempts: config.delayBetweenAttempts),
            for: RetryConfiguration.self
        )

        try container.register(NetworkRetryHandler(configuration: container.resolve()), for: RetryableOperation.self)
        try container.register(
            RemoteExoplanetRepository(
                dataSource: container.resolve(),
                retryHandler: container.resolve()),
            for: ExoplanetRepository.self
        )
    }

    private func registerDomainLayer() throws {
        try container.register(ExoplanetUseCase(repository: container.resolve()), for: ExoplanetProcessing.self)
    }

    private func registerPresentationLayer() throws {
        try container.register(TerminalMessagePrinter(), for: MessagePrinter.self)
        try container.register(TerminalExoplanetView(printer: container.resolve()), for: ExoplanetDisplaying.self)
        try container.register(TimelineFormatter(), for: TimelineFormatting.self)
        try container.register(
            ExoplanetPresenter(
                useCases: container.resolve(),
                view: container.resolve(),
                formatter: container.resolve()),
            for: ExoplanetPresenting.self
        )
    }

    public func start() async throws {
        let presenter: ExoplanetPresenting = try container.resolve()
        _ = try await presenter.presentExoplanets()
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
