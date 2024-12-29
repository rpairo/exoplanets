import Configuration

public struct EnvironmentConfigurationProvider: AppConfigurationProvider {
    private let environment: Environment

    public init(environment: Environment) {
        self.environment = environment
    }

    public func provideConfiguration() -> AppConfiguration {
        return ConfigurationFactory.create(for: environment)
    }
}
