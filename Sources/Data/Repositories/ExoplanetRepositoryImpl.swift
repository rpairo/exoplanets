import Foundation
import Domain

public final class ExoplanetRepositoryImpl: ExoplanetRepository {
    private let dataSource: ExoplanetDataSource
    private let retryHandler: RetryableOperation

    public init(dataSource: ExoplanetDataSource, config: RetryConfig = .init()) {
        self.dataSource = dataSource
        self.retryHandler = NetworkRetryHandler(config: config)
    }

    public func fetchExoplanets() async throws -> [Exoplanet] {
        try await retryHandler.execute {
            try await self.dataSource.fetch()
        }
    }
}
