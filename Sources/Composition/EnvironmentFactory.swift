import Configuration
import Foundation

public struct EnvironmentFactory {
    public static func create() -> Environment {
        guard let appEnv = ProcessInfo.processInfo.environment["APP_ENV"] else { return .production }
        switch appEnv.lowercased() {
        case "production":
            return .production
        case "testing":
            return .testing
        default:
            fatalError("Unknown environment: \(appEnv)")
        }
    }
}

