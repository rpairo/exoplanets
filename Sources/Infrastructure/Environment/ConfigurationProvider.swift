import Configuration

public struct ConfigurationProvider: AppConfigurationProvider {
    public init() {}

    public func provideConfiguration() -> AppConfiguration {
        ConfigurationFactory.create()
    }
}
