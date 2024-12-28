import Domain

public protocol ExoplanetView {
    func displayOrphanPlanets(_ planetsCount: Int, planetIdentifiers: [String])
    func displayHottestStar(identifier: String, temperature: Int)
    func displayTimeline(headers: String, separator: String, rows: [String])
    func displayError(_ message: String)
}
