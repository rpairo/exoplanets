import XCTest
@testable import Composition
@testable import Infrastructure
@testable import Data
@testable import Domain
@testable import Presentation

final class AppCompositionTests: XCTestCase {
    // MARK: - Mock DIContainer
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

    // MARK: - Tests
    func test_build_shouldRegisterAllComponents() async throws {
        let mockContainer = MockDIContainer.shared
        let appComposition = AppComposition(with: mockContainer)

        try await appComposition.build()

        do {
            let _: AppConfigurationProvider = try mockContainer.resolve()
            let _: HTTPClient = try mockContainer.resolve()
            let _: ExoplanetRepository = try mockContainer.resolve()
            let _: ExoplanetProcessing = try mockContainer.resolve()
            let _: ExoplanetPresenting = try mockContainer.resolve()
        } catch {
            XCTFail("All dependencies should be registered")
        }
    }

    func test_build_withMissingDependency_shouldThrowError() async {
        let mockContainer = MockDIContainer.shared
        let appComposition = AppComposition(with: mockContainer)

        do {
            try await appComposition.build()

            mockContainer.reset()

            let _: HTTPClient = try mockContainer.resolve()
            XCTFail("Resolving HTTPClient should throw an error when unregistered")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil for missing dependencies")
        }
    }
}
