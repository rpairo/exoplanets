import Foundation

public final class DIContainer {
    public static let shared = DIContainer()
    private var services: [String: Any] = [:]
    private init() {}

    public func register<Service>(_ service: Service, for protocolType: Service.Type) throws {
        let key = String(describing: protocolType)
        if services[key] != nil {
            throw DIContainerError.dependencyAlreadyRegistered(dependency: key)
        }
        services[key] = service
    }

    public func resolve<Service>() throws -> Service {
        let key = String(describing: Service.self)
        guard let service = services[key] as? Service else {
            throw DIContainerError.dependencyNotFound(dependency: key)
        }
        return service
    }

    public func reset() {
        services.removeAll()
    }
}

enum DIContainerError: Error {
    case dependencyAlreadyRegistered(dependency: String)
    case dependencyNotFound(dependency: String)
}

extension DIContainerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dependencyAlreadyRegistered(let dependency):
            return "The dependency '\(dependency)' is already registered."
        case .dependencyNotFound(let dependency):
            return "The dependency '\(dependency)' is not registered."
        }
    }
}
