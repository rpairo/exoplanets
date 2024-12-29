import Domain

public protocol ExoplanetDisplaying {
    func showOrphanPlanets(_ count: Int, identifiers: [String])
    func showHottestStar(identifier: String, temperature: Int)
    func showTimeline(headers: String, separator: String, rows: [String])
    func showError(_ message: String)
}
