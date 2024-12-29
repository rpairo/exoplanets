import Configuration

public struct ConfigurationFactory {
    static func create(for environment: Environment) -> AppConfiguration {
        switch environment {
        case .production:
            return productionConfiguration()
        case .testing:
            return testingConfiguration()
        }
    }

    private static func productionConfiguration() -> AppConfiguration {
        AppConfiguration(
            baseAPIURL: "https://gist.githubusercontent.com",
            exoplanetsEndpoint: "/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets",
            maxAttempts: 5,
            delayBetweenAttempts: 2.0
        )
    }

    private static func testingConfiguration() -> AppConfiguration {
        AppConfiguration(
            baseAPIURL: "https://mock.test",
            exoplanetsEndpoint: "/exoplanet",
            maxAttempts: 1,
            delayBetweenAttempts: 0.1
        )
    }
}
