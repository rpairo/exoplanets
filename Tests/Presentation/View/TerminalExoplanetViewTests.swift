import XCTest
@testable import Presentation
@testable import Domain

final class TerminalExoplanetViewTests: XCTestCase {
    // MARK: - Tests
    func test_show_withValidData_shouldPrintAllSections() {
        let presenter = MockPresenter()
        presenter.orphanPlanetsResult = [Exoplanet(planetIdentifier: "Orphan", typeFlag: 3)]
        presenter.hottestStarExoplanetResult = Exoplanet(planetIdentifier: "HotStar", typeFlag: 1)
        presenter.timelineResult = [2022: PlanetSizeCount(small: 1, medium: 2, large: 3)]

        let printer = MockPrinter()
        let formatter = MockFormatter()
        let view = TerminalExoplanetView(presenter: presenter, printer: printer, timelineFormatter: formatter)

        view.show()

        XCTAssertTrue(printer.printedMessages.contains("1. Orphan Planets Found: 1"), "Orphan planets section should be printed")
        XCTAssertTrue(printer.printedMessages.contains("\n2. Hottest Star System:\n - Planet: HotStar\n - Temperature: 0K"), "Hottest star section should be printed")
        XCTAssertTrue(printer.printedMessages.contains("\n3. Discovery Timeline:\nHeader\n-----\nRow1\nRow2"), "Timeline header should be printed")
    }

    func test_show_withEmptyData_shouldHandleGracefully() {
        let presenter = MockPresenter()
        let printer = MockPrinter()
        let formatter = MockFormatter()
        let view = TerminalExoplanetView(presenter: presenter, printer: printer, timelineFormatter: formatter)

        view.show()

        XCTAssertTrue(printer.printedMessages.isEmpty, "No messages should be printed for empty data")
    }
}
