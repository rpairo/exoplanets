import Foundation

public struct ExoplanetUseCase: ExoplanetProcessing {
    private let repository: ExoplanetRepository
    private enum Constants {
        static let orphanTypeFlag = 3
    }

    public init(repository: ExoplanetRepository) {
        self.repository = repository
    }

    public func processExoplanets() async throws -> ProcessedExoplanetResult {
        let exoplanets = try await repository.fetchExoplanets()

        var orphanPlanets = [Exoplanet]()
        var timeline = YearlyPlanetSizeDistribution()
        var hottestStarExoplanet: Exoplanet?

        for exoplanet in exoplanets {
            if let record = createTimelineRecord(for: exoplanet) {
                let currentCount = timeline[record.year] ?? .zero
                timeline[record.year] = currentCount.adding(record.sizes)
            }

            if isOrphan(exoplanet: exoplanet) {
                orphanPlanets.append(exoplanet)
            }

            hottestStarExoplanet = determineHottestStar(currentHottest: hottestStarExoplanet, newExoplanet: exoplanet)
        }

        return ProcessedExoplanetResult(
            orphanPlanets: orphanPlanets,
            timeline: timeline,
            hottestStarExoplanet: hottestStarExoplanet
        )
    }

    private func createTimelineRecord(for exoplanet: Exoplanet) -> (year: Int, sizes: PlanetSizeCount)? {
        guard let year = exoplanet.discoveryYear, let radius = exoplanet.radiusJpt, radius >= 0 else { return nil }
        let category = SizeCategory(radius: radius)
        return (year: year, sizes: category.sizeCount)
    }

    private func determineHottestStar(currentHottest: Exoplanet?, newExoplanet: Exoplanet) -> Exoplanet? {
        guard let newTemp = newExoplanet.hostStarTempK else { return currentHottest }
        guard let currentTemp = currentHottest?.hostStarTempK else { return newExoplanet }
        return newTemp > currentTemp ? newExoplanet : currentHottest
    }

    private func isOrphan(exoplanet: Exoplanet) -> Bool {
        guard let flag = exoplanet.typeFlag, flag == Constants.orphanTypeFlag else { return false }
        return true
    }
}
