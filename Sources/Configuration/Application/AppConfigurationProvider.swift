public protocol AppConfigurationProvider {
    func provideConfiguration() throws -> AppConfiguration
}
