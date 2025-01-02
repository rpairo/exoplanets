import Foundation
@testable import Composition

final class MockDIContainer: DependencyInjection {
    static var shared: DependencyInjection = MockDIContainer()
    private init() { }

    private var registrations: [String: Any] = [:]

    func register<T>(_ instance: T, for type: T.Type) throws {
        let key = String(describing: type)
        registrations[key] = instance
    }

    func resolve<T>() throws -> T {
        let key = String(describing: T.self)
        guard let instance = registrations[key] as? T else {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return instance
    }

    func reset() {
        registrations.removeAll()
    }
}
