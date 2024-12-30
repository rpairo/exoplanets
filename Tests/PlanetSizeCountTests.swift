import XCTest
@testable import Domain

final class PlanetSizeCountTests: XCTestCase {
    func test_environment_variables() {
        guard let base = ProcessInfo.processInfo.environment["BASE_URL"] else {
            XCTFail()
            return
        }
        guard let path = ProcessInfo.processInfo.environment["PATH_SEGMENT"] else {
            XCTFail()
            return
        }
        guard let endpoint = ProcessInfo.processInfo.environment["ENDPOINT_EXOPLANETS"] else {
            XCTFail()
            return
        }

        XCTAssertEqual(base, "https://gist.githubusercontent.com")
        XCTAssertEqual(path, "/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe")
        XCTAssertEqual(endpoint, "/exoplanets")
    }

    func test_init_shouldInitializeWithCorrectValues() {
        let sut = PlanetSizeCount(small: 1, medium: 2, large: 3)

        XCTAssertEqual(sut.small, 1)
        XCTAssertEqual(sut.medium, 2)
        XCTAssertEqual(sut.large, 3)
    }

    func test_zero_shouldReturnZeroValues() {
        let sut = PlanetSizeCount.zero

        XCTAssertEqual(sut.small, 0)
        XCTAssertEqual(sut.medium, 0)
        XCTAssertEqual(sut.large, 0)
    }

    func test_adding_shouldCombineValues() {
        let sut = PlanetSizeCount(small: 1, medium: 2, large: 3)
        let other = PlanetSizeCount(small: 2, medium: 3, large: 4)
        let result = sut.adding(other)

        XCTAssertEqual(result.small, 3)
        XCTAssertEqual(result.medium, 5)
        XCTAssertEqual(result.large, 7)
    }

    func test_adding_withZeroValues_shouldReturnOriginalValues() {
        let sut = PlanetSizeCount(small: 1, medium: 2, large: 3)
        let result = sut.adding(.zero)

        XCTAssertEqual(result.small, 1)
        XCTAssertEqual(result.medium, 2)
        XCTAssertEqual(result.large, 3)
    }

    func test_equatable_withSameValues_shouldBeEqual() {
        let sut1 = PlanetSizeCount(small: 1, medium: 2, large: 3)
        let sut2 = PlanetSizeCount(small: 1, medium: 2, large: 3)

        XCTAssertEqual(sut1, sut2)
    }

    func test_equatable_withDifferentValues_shouldNotBeEqual() {
        let sut1 = PlanetSizeCount(small: 1, medium: 2, large: 3)
        let sut2 = PlanetSizeCount(small: 3, medium: 2, large: 2)

        XCTAssertNotEqual(sut1, sut2)
    }
}
