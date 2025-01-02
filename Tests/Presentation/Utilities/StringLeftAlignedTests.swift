import XCTest
import Presentation

final class StringLeftAlignedTests: XCTestCase {
    func test_leftAligned_whenStringIsShorterThanWidth_shouldAddPadding() {
        let input = "Hello"
        let expectedOutput = "Hello     "
        let width = 10

        let result = input.leftAligned(to: width)

        XCTAssertEqual(result, expectedOutput, "The string should be padded to the specified width.")
    }

    func test_leftAligned_whenStringIsEqualToWidth_shouldNotAddPadding() {
        let input = "HelloWorld"
        let expectedOutput = "HelloWorld"
        let width = 10

        let result = input.leftAligned(to: width)

        XCTAssertEqual(result, expectedOutput, "The string should not be modified if its length equals the specified width.")
    }

    func test_leftAligned_whenStringIsLongerThanWidth_shouldNotModifyString() {
        let input = "HelloWorld!"
        let expectedOutput = "HelloWorld!"
        let width = 10

        let result = input.leftAligned(to: width)

        XCTAssertEqual(result, expectedOutput, "The string should not be modified if its length exceeds the specified width.")
    }

    func test_leftAligned_withEmptyString_shouldReturnSpaces() {
        let input = ""
        let expectedOutput = "     "
        let width = 5

        let result = input.leftAligned(to: width)

        XCTAssertEqual(result, expectedOutput, "An empty string should be padded with spaces up to the specified width.")
    }

    func test_leftAligned_withWidthZero_shouldReturnOriginalString() {
        let input = "Hello"
        let expectedOutput = "Hello"
        let width = 0

        let result = input.leftAligned(to: width)

        XCTAssertEqual(result, expectedOutput, "The string should not be modified if the width is zero.")
    }
}
