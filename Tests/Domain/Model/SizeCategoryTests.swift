import XCTest
@testable import Domain

final class SizeCategoryTests: XCTestCase {
    func test_init_withSmallRadius_shouldClassifyAsSmall() {
        let radius = 0.5
        let sut = SizeCategory(radius: radius)

        XCTAssertEqual(sut, .small)
    }

    func test_init_withMediumRadius_shouldClassifyAsMedium() {
        let radius = 1.5
        let sut = SizeCategory(radius: radius)

        XCTAssertEqual(sut, .medium)
    }

    func test_init_withLargeRadius_shouldClassifyAsLarge() {
        let radius = 2.5
        let sut = SizeCategory(radius: radius)

        XCTAssertEqual(sut, .large)
    }

    func test_init_withBoundaryValues_shouldClassifyCorrectly() {
        XCTAssertEqual(SizeCategory(radius: 0.0), .small)
        XCTAssertEqual(SizeCategory(radius: 0.99), .small)
        XCTAssertEqual(SizeCategory(radius: 1.0), .medium)
        XCTAssertEqual(SizeCategory(radius: 1.99), .medium)
        XCTAssertEqual(SizeCategory(radius: 2.0), .large)
        XCTAssertEqual(SizeCategory(radius: 2.01), .large)
    }

    func test_sizeCount_withSmallCategory_shouldReturnCorrectCount() {
        let sut = SizeCategory.small
        let count = sut.sizeCount

        XCTAssertEqual(count.small, 1)
        XCTAssertEqual(count.medium, 0)
        XCTAssertEqual(count.large, 0)
    }

    func test_sizeCount_withMediumCategory_shouldReturnCorrectCount() {
        let sut = SizeCategory.medium
        let count = sut.sizeCount

        XCTAssertEqual(count.small, 0)
        XCTAssertEqual(count.medium, 1)
        XCTAssertEqual(count.large, 0)
    }

    func test_sizeCount_withLargeCategory_shouldReturnCorrectCount() {
        let sut = SizeCategory.large
        let count = sut.sizeCount

        XCTAssertEqual(count.small, 0)
        XCTAssertEqual(count.medium, 0)
        XCTAssertEqual(count.large, 1)
    }

    func test_thresholdValues_shouldBeCorrect() {
        XCTAssertEqual(SizeCategory.smallThreshold, 1.0)
        XCTAssertEqual(SizeCategory.mediumThreshold, 2.0)
    }
}
