public struct AppConfiguration {
    private let baseAPIURL: String
    private let exoplanetsPathSegment: String
    private let exoplanetsEndpoint: String
    public var apiURL: String { baseAPIURL + exoplanetsPathSegment + exoplanetsEndpoint }
    public let apiRequestMaxAttempts: Int
    public let delayBetweenAttempts: Double

    public init(baseAPIURL: String, exoplanetsPathSegment: String, exoplanetsEndpoint: String, apiRequestMaxAttempts: Int, delayBetweenAttempts: Double) {
        self.baseAPIURL = baseAPIURL
        self.exoplanetsPathSegment = exoplanetsPathSegment
        self.exoplanetsEndpoint = exoplanetsEndpoint
        self.apiRequestMaxAttempts = apiRequestMaxAttempts
        self.delayBetweenAttempts = delayBetweenAttempts
    }
}
