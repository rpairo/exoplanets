public final class DIContainer {
    public static let shared = DIContainer()

    private var services: [String: Any] = [:]

    private init() {}

    func register<Service>(_ service: Service, for protocolType: Service.Type) {
        let key = String(describing: protocolType)
        services[key] = service
    }

    func resolve<Service>() -> Service {
        let key = String(describing: Service.self)
        guard let service = services[key] as? Service else {
            fatalError("No registered service for type \(Service.self)")
        }
        return service
    }

    public func reset() {
        services.removeAll()
    }
}
