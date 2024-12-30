import Foundation

public struct ConfigurationFactory {
    static func create() throws -> AppConfiguration {
        let baseURLKey = "BASE_URL"
        let pathSegmentKey = "PATH_SEGMENT"
        let endpointKey = "ENDPOINT_EXOPLANETS"

        guard let base = ProcessInfo.processInfo.environment[baseURLKey] else {
            throw ConfigurationError.missingEnvironmentVariable(baseURLKey)
        }
        guard let path = ProcessInfo.processInfo.environment[pathSegmentKey] else {
            throw ConfigurationError.missingEnvironmentVariable(pathSegmentKey)
        }
        guard let endpoint = ProcessInfo.processInfo.environment[endpointKey] else {
            throw ConfigurationError.missingEnvironmentVariable(endpointKey)
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
