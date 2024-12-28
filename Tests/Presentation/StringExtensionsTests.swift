import XCTest
@testable import Presentation

final class StringExtensionsTests: XCTestCase {
    func test_leftAligned_withShorterString() {
        let sut = "test"
        let result = sut.leftAligned(to: 6)
        XCTAssertEqual(result, "test  ")
    }

    func test_leftAligned_withLongerString() {
        let sut = "testing"
        let result = sut.leftAligned(to: 4)
        XCTAssertEqual(result, "testing")
    }

    func test_leftAligned_withEqualLength() {
        let sut = "test"
        let result = sut.leftAligned(to: 4)
        XCTAssertEqual(result, "test")
    }
}
