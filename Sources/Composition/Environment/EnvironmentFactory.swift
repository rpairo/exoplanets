import Configuration
import Foundation

public struct EnvironmentFactory {
    public static func create() throws -> Environment {
        guard let appEnv = ProcessInfo.processInfo.environment["APP_ENV"] else { return .production }
        switch appEnv.lowercased() {
        case "production":
            return .production
        case "testing":
            return .testing
        default:
            throw EnvironmentError.unknownEnvironment(appEnv)
        }
    }
}

enum EnvironmentError: Error {
    case unknownEnvironment(String)
}

extension EnvironmentError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownEnvironment(let env):
            return "The environment '\(env)' is unknown."
        }
    }
}
