public struct AppConfiguration {
    private let baseAPIURL: String
    private let exoplanetsEndpoint: String
    public var apiURL: String { baseAPIURL + exoplanetsEndpoint }
    public let maxAttempts: Int
    public let delayBetweenAttempts: Double

    public init(baseAPIURL: String, exoplanetsEndpoint: String, maxAttempts: Int, delayBetweenAttempts: Double) {
        self.baseAPIURL = baseAPIURL
        self.exoplanetsEndpoint = exoplanetsEndpoint
        self.maxAttempts = maxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }
}
