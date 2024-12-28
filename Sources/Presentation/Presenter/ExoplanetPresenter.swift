import Domain

public final class ExoplanetPresenter: ExoplanetPresenting {
    private let useCase: ExoplanetProcessing
    private let view: ExoplanetView

    public init(useCases: ExoplanetProcessing, view: ExoplanetView) {
        self.useCase = useCases
        self.view = view
    }

    public func present() async throws -> PresentationResult {
        do {
            let result = try await useCase.processExoplanets()
            updateView(with: result)
            return .success(result)
        } catch {
            view.displayError(error.localizedDescription)
            return .failure(error)
        }
    }

    private func updateView(with result: ProcessedExoplanetResult) {
        if let orphans = result.orphanPlanets {
            let identifiers = orphans.map { $0.planetIdentifier ?? "Unknown" }
            view.displayOrphanPlanets(orphans.count, planetIdentifiers: identifiers)
        }

        if let hottest = result.hottestStarExoplanet {
            let identifier = hottest.planetIdentifier ?? "Unknown"
            let temperature = hottest.hostStarTempK ?? 0
            view.displayHottestStar(identifier: identifier, temperature: temperature)
        }

        if let timeline = result.timeline {
            let (headers, separator, rows) = formatTimeline(timeline)
            view.displayTimeline(headers: headers, separator: separator, rows: rows)
        }
    }

    private func formatTimeline(_ timeline: YearlyPlanetSizeDistribution) -> (String, String, [String]) {
        let yearMargin = 6
        let smallMargin = 6
        let mediumMargin = 7
        let largeMargin = 5

        let yearHeader = "Year".leftAligned(to: yearMargin)
        let smallHeader = "Small".leftAligned(to: smallMargin)
        let mediumHeader = "Medium".leftAligned(to: mediumMargin)
        let largeHeader = "Large".leftAligned(to: largeMargin)
        let headers = "\(yearHeader) \(smallHeader) \(mediumHeader) \(largeHeader)"

        let separator = String(repeating: "-", count: headers.count)

        let sortedTimeline = timeline.sorted { $0.key < $1.key }
        let rows = sortedTimeline.map { year, data in
            let yearStr = String(year).leftAligned(to: yearMargin)
            let smallStr = String(data.small).leftAligned(to: smallMargin)
            let mediumStr = String(data.medium).leftAligned(to: mediumMargin)
            let largeStr = String(data.large).leftAligned(to: largeMargin)
            return "\(yearStr) \(smallStr) \(mediumStr) \(largeStr)"
        }

        return (headers, separator, rows)
    }
}

extension String {
    func leftAligned(to width: Int) -> String {
        if count >= width {
            return self
        }
        return self + String(repeating: " ", count: width - count)
    }
}
