public protocol ExoplanetProcessing {
    func processExoplanets() async throws -> ProcessedExoplanetResult
}
