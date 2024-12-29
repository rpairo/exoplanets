public struct TerminalExoplanetView: ExoplanetDisplaying {
    private let printer: MessagePrinter

    public init(printer: MessagePrinter) {
        self.printer = printer
    }

    public func showOrphanPlanets(_ count: Int, identifiers: [String]) {
        printer.printMessage("1. Orphan Planets Found: \(count)")
        identifiers.forEach { identifier in
            printer.printMessage(" - \(identifier)")
        }
    }

    public func showHottestStar(identifier: String, temperature: Int) {
        printer.printMessage("\n2. Hottest Star System:")
        printer.printMessage(" - Planet: \(identifier)")
        printer.printMessage(" - Temperature: \(temperature)K")
    }

    public func showTimeline(headers: String, separator: String, rows: [String]) {
        printer.printMessage("\n3. Discovery Timeline:")
        printer.printMessage(headers)
        printer.printMessage(separator)
        rows.forEach { printer.printMessage($0) }
    }

    public func showError(_ message: String) {
        printer.printMessage("Error: \(message)")
    }
}
