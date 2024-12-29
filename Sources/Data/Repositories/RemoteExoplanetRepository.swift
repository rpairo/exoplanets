import Foundation
import Domain

public struct RemoteExoplanetRepository: ExoplanetRepository {
    private let dataSource: ExoplanetDataSource
    private let retryHandler: RetryableOperation

    public init(dataSource: ExoplanetDataSource, retryHandler: RetryableOperation) {
        self.dataSource = dataSource
        self.retryHandler = retryHandler
    }

    public func fetchExoplanets() async throws -> [Exoplanet] {
        try await retryHandler.execute {
            try await self.dataSource.fetch()
        }
    }
}
