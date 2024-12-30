import Foundation

public struct ConfigurationFactory {
    static func create() throws -> AppConfiguration {
        guard let base = ProcessInfo.processInfo.environment["BASE_URL"] else {
            throw ConfigurationError.missingEnvironmentVariable("BASE_URL")
        }
        guard let path = ProcessInfo.processInfo.environment["PATH_SEGMENT"] else {
            throw ConfigurationError.missingEnvironmentVariable("PATH_SEGMENT")
        }
        guard let endpoint = ProcessInfo.processInfo.environment["ENDPOINT_EXOPLANETS"] else {
            throw ConfigurationError.missingEnvironmentVariable("ENDPOINT_EXOPLANETS")
        }

        return AppConfiguration(
            baseAPIURL: base,
            exoplanetsPathSegment: path,
            exoplanetsEndpoint: endpoint,
            maxAttempts: 5,
            delayBetweenAttempts: 2.0
        )
    }
}

public enum ConfigurationError: Error, LocalizedError {
    case missingEnvironmentVariable(String)

    public var errorDescription: String? {
        switch self {
        case .missingEnvironmentVariable(let variable):
            return "Missing environment variable: \(variable)"
        }
    }
}
