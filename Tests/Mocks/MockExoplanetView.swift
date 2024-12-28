import XCTest
@testable import Presentation

final class MockExoplanetView: ExoplanetView {
    private(set) var displayOrphanPlanetsCallCount = 0
    private(set) var displayHottestStarCallCount = 0
    private(set) var displayTimelineCallCount = 0
    private(set) var displayErrorCallCount = 0

    private(set) var lastOrphanPlanetsData: (count: Int, identifiers: [String])?
    private(set) var lastHottestStarData: (identifier: String, temperature: Int)?
    private(set) var lastTimelineData: (headers: String, separator: String, rows: [String])?
    private(set) var lastErrorMessage: String?

    func displayOrphanPlanets(_ count: Int, planetIdentifiers: [String]) {
        displayOrphanPlanetsCallCount += 1
        lastOrphanPlanetsData = (count, planetIdentifiers)
    }

    func displayHottestStar(identifier: String, temperature: Int) {
        displayHottestStarCallCount += 1
        lastHottestStarData = (identifier, temperature)
    }

    func displayTimeline(headers: String, separator: String, rows: [String]) {
        displayTimelineCallCount += 1
        lastTimelineData = (headers, separator, rows)
    }

    func displayError(_ message: String) {
        displayErrorCallCount += 1
        lastErrorMessage = message
    }
}
