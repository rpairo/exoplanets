public typealias RepositoryResult = [Exoplanet]

public protocol ExoplanetRepository {
    func fetchExoplanets() async throws -> RepositoryResult
}
