import XCTest
@testable import Composition

final class DIContainerTests: XCTestCase {
    // MARK: - Mock Services for Testing
    protocol MockServiceProtocol {}
    class MockService: MockServiceProtocol {}

    protocol AnotherMockServiceProtocol {}
    class AnotherMockService: AnotherMockServiceProtocol {}

    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        DIContainer.shared.reset()
    }

    override func tearDown() {
        DIContainer.shared.reset()
        super.tearDown()
    }

    // MARK: - Tests
    func test_registerAndResolve_shouldReturnRegisteredService() throws {
        let mockService = MockService()
        try DIContainer.shared.register(mockService, for: MockServiceProtocol.self)

        let resolvedService: MockServiceProtocol = try DIContainer.shared.resolve()
        XCTAssertTrue(resolvedService is MockService, "Resolved service should match the registered service.")
    }

    func test_registerDuplicateService_shouldThrowError() throws {
        let mockService = MockService()
        try DIContainer.shared.register(mockService, for: MockServiceProtocol.self)

        XCTAssertThrowsError(try DIContainer.shared.register(mockService, for: MockServiceProtocol.self)) { error in
            guard let error = error as? DIContainerError else {
                return XCTFail("Expected DIContainerError, but got \(error).")
            }
            XCTAssertEqual(
                error.localizedDescription,
                DIContainerError.dependencyAlreadyRegistered(dependency: "MockServiceProtocol").localizedDescription
            )
        }
    }

    func test_resolveUnregisteredService_shouldThrowError() {
        XCTAssertThrowsError(try DIContainer.shared.resolve() as MockServiceProtocol) { error in
            guard let error = error as? DIContainerError else {
                return XCTFail("Expected DIContainerError, but got \(error).")
            }
            XCTAssertEqual(
                error.localizedDescription,
                DIContainerError.dependencyNotFound(dependency: "MockServiceProtocol").localizedDescription
            )
        }
    }

    func test_reset_shouldClearAllRegistrations() throws {
        let mockService = MockService()
        try DIContainer.shared.register(mockService, for: MockServiceProtocol.self)

        DIContainer.shared.reset()

        XCTAssertThrowsError(try DIContainer.shared.resolve() as MockServiceProtocol) { error in
            guard let error = error as? DIContainerError else {
                return XCTFail("Expected DIContainerError, but got \(error).")
            }
            XCTAssertEqual(
                error.localizedDescription,
                DIContainerError.dependencyNotFound(dependency: "MockServiceProtocol").localizedDescription
            )
        }
    }

    func test_registerMultipleServices_shouldResolveIndependently() throws {
        let mockService = MockService()
        let anotherMockService = AnotherMockService()

        try DIContainer.shared.register(mockService, for: MockServiceProtocol.self)
        try DIContainer.shared.register(anotherMockService, for: AnotherMockServiceProtocol.self)

        let resolvedMockService: MockServiceProtocol = try DIContainer.shared.resolve()
        let resolvedAnotherService: AnotherMockServiceProtocol = try DIContainer.shared.resolve()

        XCTAssertTrue(resolvedMockService is MockService, "First resolved service should match the registered MockService.")
        XCTAssertTrue(resolvedAnotherService is AnotherMockService, "Second resolved service should match the registered AnotherMockService.")
    }
}
