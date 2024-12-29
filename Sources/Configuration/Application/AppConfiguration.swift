public struct AppConfiguration {
    private let baseAPIURL: String
    private let exoplanetsPathSegment: String
    private let exoplanetsEndpoint: String
    public var apiURL: String { baseAPIURL + exoplanetsPathSegment + exoplanetsEndpoint }
    public let maxAttempts: Int
    public let delayBetweenAttempts: Double

    public init(baseAPIURL: String, exoplanetsPathSegment: String, exoplanetsEndpoint: String, maxAttempts: Int, delayBetweenAttempts: Double) {
        self.baseAPIURL = baseAPIURL
        self.exoplanetsPathSegment = exoplanetsPathSegment
        self.exoplanetsEndpoint = exoplanetsEndpoint
        self.maxAttempts = maxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }
}
