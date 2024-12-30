public struct TerminalExoplanetView: ExoplanetDisplaying {
    private let presenter: ExoplanetPresenting
    private let printer: MessagePrinter
    private let timelineFormatter: TimelineFormatting

    public init(presenter: ExoplanetPresenting, printer: MessagePrinter, timelineFormatter: TimelineFormatting) {
        self.presenter = presenter
        self.printer = printer
        self.timelineFormatter = timelineFormatter

        show()
    }

    public func show() {
        if let orphans = presenter.orphanPlanets() {
            let identifiers = orphans.map { $0.planetIdentifier ?? "Unknown" }
            showOrphanPlanets(orphans.count, identifiers: identifiers)
        }

        if let hottest = presenter.hottestStarExoplanet() {
            let identifier = hottest.planetIdentifier ?? "Unknown"
            let temperature = hottest.hostStarTempK ?? 0
            showHottestStar(identifier: identifier, temperature: temperature)
        }

        if let timeline = presenter.timeline() {
            let formattedTimeline = timelineFormatter.format(timeline)
            showTimeline(headers: formattedTimeline.headers, separator: formattedTimeline.separator, rows: formattedTimeline.rows)
        }
    }

    private func showOrphanPlanets(_ count: Int, identifiers: [String]) {
        printer.printMessage("1. Orphan Planets Found: \(count)")
        identifiers.forEach { identifier in
            printer.printMessage(" - \(identifier)")
        }
    }

    private func showHottestStar(identifier: String, temperature: Int) {
        printer.printMessage("\n2. Hottest Star System:")
        printer.printMessage(" - Planet: \(identifier)")
        printer.printMessage(" - Temperature: \(temperature)K")
    }

    private func showTimeline(headers: String, separator: String, rows: [String]) {
        printer.printMessage("\n3. Discovery Timeline:")
        printer.printMessage(headers)
        printer.printMessage(separator)
        rows.forEach { printer.printMessage($0) }
    }
}
