import Domain

public protocol ExoplanetDataSource {
    func fetch() async throws -> [Exoplanet]
}
