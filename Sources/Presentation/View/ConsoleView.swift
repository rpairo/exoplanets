public struct ConsoleView: ExoplanetView {
    private let printer: (String) -> Void

    public init(printer: @escaping (String) -> Void = { Swift.print($0) }) {
        self.printer = printer
    }

    public func displayOrphanPlanets(_ planetsCount: Int, planetIdentifiers: [String]) {
        printer("1. Orphan Planets Found: \(planetsCount)")
        planetIdentifiers.forEach { identifier in
            printer(" - \(identifier)")
        }
    }

    public func displayHottestStar(identifier: String, temperature: Int) {
        printer("\n2. Hottest Star System:")
        printer(" - Planet: \(identifier)")
        printer(" - Temperature: \(temperature)K")
    }

    public func displayTimeline(headers: String, separator: String, rows: [String]) {
        printer("\n3. Discovery Timeline:")
        printer(headers)
        printer(separator)
        rows.forEach { printer($0) }
    }

    public func displayError(_ message: String) {
        printer("Error: \(message)")
    }
}
