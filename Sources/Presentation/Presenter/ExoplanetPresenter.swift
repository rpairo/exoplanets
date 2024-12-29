import Domain

public struct ExoplanetPresenter: ExoplanetPresenting {
    private let useCase: ExoplanetProcessing
    private let view: ExoplanetDisplaying
    private let timelineFormatter: TimelineFormatting

    public init(useCases: ExoplanetProcessing, view: ExoplanetDisplaying, formatter: TimelineFormatting) {
        self.useCase = useCases
        self.view = view
        self.timelineFormatter = formatter
    }

    public func presentExoplanets() async throws -> PresentationResult {
        do {
            let result = try await useCase.processExoplanets()
            updateView(with: result)
            return .success(result)
        } catch {
            view.showError(error.localizedDescription)
            return .failure(error)
        }
    }

    private func updateView(with result: ProcessedExoplanetResult) {
        if let orphans = result.orphanPlanets {
            let identifiers = orphans.map { $0.planetIdentifier ?? "Unknown" }
            view.showOrphanPlanets(orphans.count, identifiers: identifiers)
        }

        if let hottest = result.hottestStarExoplanet {
            let identifier = hottest.planetIdentifier ?? "Unknown"
            let temperature = hottest.hostStarTempK ?? 0
            view.showHottestStar(identifier: identifier, temperature: temperature)
        }

        if let timeline = result.timeline {
            let formattedTimeline = timelineFormatter.format(timeline)
            view.showTimeline(headers: formattedTimeline.headers, separator: formattedTimeline.separator, rows: formattedTimeline.rows)
        }
    }
}
