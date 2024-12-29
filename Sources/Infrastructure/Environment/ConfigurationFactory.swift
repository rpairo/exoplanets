import Configuration
import Foundation

public struct ConfigurationFactory {
    static func create() -> AppConfiguration {
        guard let base = ProcessInfo.processInfo.environment["BASE_URL"] else { fatalError() }
        guard let path = ProcessInfo.processInfo.environment["PATH_SEGMENT"] else { fatalError() }
        guard let endpoint = ProcessInfo.processInfo.environment["ENDPOINT_EXOPLANETS"] else { fatalError() }

        return AppConfiguration(
            baseAPIURL: base,
            exoplanetsPathSegment: path,
            exoplanetsEndpoint: endpoint,
            maxAttempts: 5,
            delayBetweenAttempts: 2.0
        )
    }
}
