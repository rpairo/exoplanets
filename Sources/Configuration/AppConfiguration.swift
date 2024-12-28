public struct AppConfiguration {
    private let baseAPIURL: String
    private let exoplanetsEndpoint: String
    public var apiURL: String { baseAPIURL + exoplanetsEndpoint }

    public init(baseAPIURL: String, exoplanetsEndpoint: String) {
        self.baseAPIURL = baseAPIURL
        self.exoplanetsEndpoint = exoplanetsEndpoint
    }
}
