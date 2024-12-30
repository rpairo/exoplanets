import Domain

public struct ExoplanetPresenter: ExoplanetPresenting {
    private let useCase: ExoplanetProcessing
    private var result: ProcessedExoplanetResult?

    public init(useCases: ExoplanetProcessing) async throws {
        self.useCase = useCases

        self.result = try await self.prepareExoplanets()
    }

    private func prepareExoplanets() async throws -> ProcessedExoplanetResult {
        do {
            return try await useCase.processExoplanets()
        } catch {
            throw error
        }
    }

    public func orphanPlanets() -> [Exoplanet]? {
        self.result?.orphanPlanets
    }

    public func hottestStarExoplanet() -> Exoplanet? {
        self.result?.hottestStarExoplanet
    }

    public func timeline() -> YearlyPlanetSizeDistribution? {
        self.result?.timeline
    }
}
