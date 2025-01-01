import XCTest
@testable import Presentation
@testable import Domain

final class TimelineFormatterTests: XCTestCase {
    // MARK: - Tests
    func test_format_withValidTimeline_shouldReturnFormattedStrings() {
        let timeline: YearlyPlanetSizeDistribution = [
            2022: PlanetSizeCount(small: 1, medium: 2, large: 3),
            2021: PlanetSizeCount(small: 4, medium: 5, large: 6)
        ]
        let formatter = TimelineFormatter()
        let formatted = formatter.format(timeline)

        XCTAssertEqual(formatted.headers, "Year   Small  Medium  Large", "Headers should be formatted correctly")
        XCTAssertEqual(formatted.separator, "---------------------------", "Separator should match header length")
        XCTAssertEqual(formatted.rows.count, 2, "Rows count should match timeline entries")
        XCTAssertEqual(formatted.rows[0], "2021   4      5       6    ", "Row for 2021 should be formatted correctly")
        XCTAssertEqual(formatted.rows[1], "2022   1      2       3    ", "Row for 2022 should be formatted correctly")
    }

    func test_format_withEmptyTimeline_shouldReturnEmptyRows() {
        let timeline: YearlyPlanetSizeDistribution = [:]
        let formatter = TimelineFormatter()
        let formatted = formatter.format(timeline)

        XCTAssertEqual(formatted.headers, "Year   Small  Medium  Large", "Headers should still be formatted correctly")
        XCTAssertEqual(formatted.separator, "---------------------------", "Separator should still match header length")
        XCTAssertTrue(formatted.rows.isEmpty, "Rows should be empty for an empty timeline")
    }

    func test_format_withLargeValues_shouldHandleCorrectly() {
        let timeline: YearlyPlanetSizeDistribution = [
            2023: PlanetSizeCount(small: 9999, medium: 8888, large: 7777)
        ]
        let formatter = TimelineFormatter()
        let formatted = formatter.format(timeline)

        XCTAssertEqual(formatted.rows.first, "2023   9999   8888    7777 ", "Row should handle large values correctly")
    }
}
