import XCTest
@testable import Infrastructure

final class AppConfigurationTests: XCTestCase {
    // MARK: - Tests

    func test_initialization_withValidValues_shouldSetPropertiesCorrectly() {
        let config = AppConfiguration(
            baseAPIURL: "https://api.test.com",
            exoplanetsPathSegment: "/exoplanets",
            exoplanetsEndpoint: "/data",
            apiRequestMaxAttempts: 3,
            delayBetweenAttempts: 2.0
        )

        XCTAssertEqual(config.apiURL, "https://api.test.com/exoplanets/data", "API URL should be correctly constructed")
        XCTAssertEqual(config.apiRequestMaxAttempts, 3, "Max attempts should match the provided value")
        XCTAssertEqual(config.delayBetweenAttempts, 2.0, "Delay between attempts should match the provided value")
    }

    func test_apiURL_withCustomSegments_shouldConstructCorrectURL() {
        let config = AppConfiguration(
            baseAPIURL: "https://custom.test.com",
            exoplanetsPathSegment: "/planets",
            exoplanetsEndpoint: "/info",
            apiRequestMaxAttempts: 2,
            delayBetweenAttempts: 1.5
        )

        XCTAssertEqual(config.apiURL, "https://custom.test.com/planets/info", "Custom segments should form the correct API URL")
    }

    func test_initialization_withEdgeValues_shouldHandleCorrectly() {
        let config = AppConfiguration(
            baseAPIURL: "",
            exoplanetsPathSegment: "",
            exoplanetsEndpoint: "",
            apiRequestMaxAttempts: 0,
            delayBetweenAttempts: 0.0
        )

        XCTAssertEqual(config.apiURL, "", "API URL should be empty for empty inputs")
        XCTAssertEqual(config.apiRequestMaxAttempts, 0, "Max attempts should be set to 0")
        XCTAssertEqual(config.delayBetweenAttempts, 0.0, "Delay between attempts should be set to 0")
    }
}
