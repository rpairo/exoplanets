import XCTest
@testable import Presentation
@testable import Domain

final class ConsoleViewTests: XCTestCase {
    private var output: [String]!
    private var sut: ConsoleView!

    override func setUp() {
        super.setUp()
        output = []
        sut = ConsoleView { [weak self] in
            self?.output.append($0)
        }
    }

    override func tearDown() {
        output = nil
        sut = nil
        super.tearDown()
    }

    func test_displayOrphanPlanets_withMultiplePlanets_shouldFormatCorrectly() {
        let exoplanets = TestFactory.makeOrphanPlanets(count: 2)
        let identifiers = exoplanets.map { $0.planetIdentifier ?? "Unknown" }
        sut.displayOrphanPlanets(exoplanets.count, planetIdentifiers: identifiers)

        XCTAssertEqual(output, [
            "1. Orphan Planets Found: 2",
            " - Orphan0",
            " - Orphan1"
        ])
    }

    func test_displayOrphanPlanets_withNoPlanets_shouldShowZero() {
        sut.displayOrphanPlanets(0, planetIdentifiers: [])

        XCTAssertEqual(output, [
            "1. Orphan Planets Found: 0"
        ])
    }

    func test_displayHottestStar_shouldFormatCorrectly() {
        sut.displayHottestStar(identifier: "Hot Planet", temperature: 10000)

        XCTAssertEqual(output, [
            "\n2. Hottest Star System:",
            " - Planet: Hot Planet",
            " - Temperature: 10000K"
        ])
    }

    func test_displayTimeline_withMultipleYears_shouldFormatCorrectly() {
        sut.displayTimeline(
            headers: "Year Small Medium Large",
            separator: "-------------------",
            rows: [
                "2000  1     2      3",
                "2001  2     1      1"
            ]
        )

        XCTAssertEqual(output, [
            "\n3. Discovery Timeline:",
            "Year Small Medium Large",
            "-------------------",
            "2000  1     2      3",
            "2001  2     1      1"
        ])
    }

    func test_displayTimeline_withEmptyTimeline_shouldOnlyShowHeaders() {
        sut.displayTimeline(
            headers: "Year Small Medium Large",
            separator: "-------------------",
            rows: []
        )

        XCTAssertEqual(output, [
            "\n3. Discovery Timeline:",
            "Year Small Medium Large",
            "-------------------"
        ])
    }

    func test_displayError_shouldFormatCorrectly() {
        sut.displayError("Test error message")

        XCTAssertEqual(output, [
            "Error: Test error message"
        ])
    }
}
