
import XCTest
@testable import Infrastructure

final class ConfigurationFactoryTests: XCTestCase {
    // MARK: - Helper Methods

    private func setEnvironmentVariables(baseURL: String?, pathSegment: String?, endpoint: String?) {
        if let baseURL = baseURL {
            setenv("BASE_URL", baseURL, 1)
        } else {
            unsetenv("BASE_URL")
        }

        if let pathSegment = pathSegment {
            setenv("PATH_SEGMENT", pathSegment, 1)
        } else {
            unsetenv("PATH_SEGMENT")
        }

        if let endpoint = endpoint {
            setenv("ENDPOINT_EXOPLANETS", endpoint, 1)
        } else {
            unsetenv("ENDPOINT_EXOPLANETS")
        }
    }



    // MARK: - Tests

    func test_configuration_withValidEnvironmentVariables_shouldInitializeCorrectly() {
        setEnvironmentVariables(baseURL: "https://api.test.com", pathSegment: "/exoplanets", endpoint: "/data")
        let defaultApiRequestMaxAttempts = 5
        let defaultDelayBetweenAttempts = 2.0

        do {
            let configuration = try ConfigurationFactory.create()
            XCTAssertEqual(configuration.apiURL, "https://api.test.com/exoplanets/data", "URL should match the environment variable")
            XCTAssertEqual(configuration.apiRequestMaxAttempts, defaultApiRequestMaxAttempts, "URL should match the environment variable")
            XCTAssertEqual(configuration.delayBetweenAttempts, defaultDelayBetweenAttempts, "URL should match the environment variable")
        } catch {

        }
    }

    func test_configuration_withMissingEnvironmentVariables_shouldThrowError() {
        setEnvironmentVariables(baseURL: nil, pathSegment: "/exoplanets", endpoint: "/data")

        XCTAssertThrowsError(try ConfigurationFactory.create()) { error in
            XCTAssertNotNil(error, "Error should be thrown when BASE_URL is missing")
        }

        setEnvironmentVariables(baseURL: "https://api.test.com", pathSegment: nil, endpoint: "/data")

        XCTAssertThrowsError(try ConfigurationFactory.create()) { error in
            XCTAssertNotNil(error, "Error should be thrown when PATH_SEGMENT is missing")
        }

        setEnvironmentVariables(baseURL: "https://api.test.com", pathSegment: "/exoplanets", endpoint: nil)

        XCTAssertThrowsError(try ConfigurationFactory.create()) { error in
            XCTAssertNotNil(error, "Error should be thrown when ENDPOINT_EXOPLANETS is missing")
        }
    }
}
