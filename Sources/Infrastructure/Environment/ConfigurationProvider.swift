public struct ConfigurationProvider: AppConfigurationProvider {
    public init() {}

    public func provideConfiguration() throws -> AppConfiguration {
        try ConfigurationFactory.create()
    }
}
