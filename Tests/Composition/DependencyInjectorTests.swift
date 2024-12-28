import XCTest
@testable import Domain
@testable import Data
@testable import Presentation
@testable import Composition

final class DependencyInjectorTests: XCTestCase {

    func test_build_withProductionEnvironment_shouldCreateValidPresenter() throws {
        // Given
        let sut = DependencyInjector(environment: .production)

        // When
        let presenter = try sut.build()

        // Then
        XCTAssertNotNil(presenter)
    }

    func test_build_withTestingEnvironment_shouldCreateValidPresenter() throws {
        // Given
        let sut = DependencyInjector(environment: .testing)

        // When
        let presenter = try sut.build()

        // Then
        XCTAssertNotNil(presenter)
    }

    func test_build_shouldCreatePresenterWithCorrectConfiguration() throws {
        // Given
        let sut = DependencyInjector(environment: .testing)

        // When
        let presenter = try sut.build()

        // Then
        let mirror = Mirror(reflecting: presenter)
        let useCase = mirror.children.first { $0.label == "useCase" }?.value
        XCTAssertNotNil(useCase)
        XCTAssertTrue(useCase is ExoplanetUseCase)
    }

    func test_build_shouldCreatePresenterWithConsoleView() throws {
        // Given
        let sut = DependencyInjector(environment: .testing)

        // When
        let presenter = try sut.build()

        // Then
        let mirror = Mirror(reflecting: presenter)
        let view = mirror.children.first { $0.label == "view" }?.value
        XCTAssertNotNil(view)
        XCTAssertTrue(view is ConsoleView)
    }

    func test_build_withInvalidConfiguration_shouldThrowError() throws {
        // Given
        let sut = DependencyInjector(environment: .testing)
        let config = EnvironmentConfigurationProvider(baseAPIURL: "", exoplanetsEndpoint: "")

        // When/Then
        XCTAssertThrowsError(try sut.build(using: config)) { error in
            XCTAssertTrue(error is ConfigurationError)
            XCTAssertEqual(error as? ConfigurationError, .invalidFormat)
        }
    }

    func test_build_shouldCreateCompleteObjectGraph() throws {
        // Given
        let sut = DependencyInjector(environment: .testing)
        
        // When
        let presenter = try sut.build()

        // Then
        let mirror = Mirror(reflecting: presenter)
        XCTAssertNotNil(mirror.children.first { $0.label == "useCase" }?.value)
        XCTAssertNotNil(mirror.children.first { $0.label == "view" }?.value)

        // Verify UseCase has repository
        if let useCase = mirror.children.first(where: { $0.label == "useCase" })?.value {
            let useCaseMirror = Mirror(reflecting: useCase)
            XCTAssertNotNil(useCaseMirror.children.first { $0.label == "repository" }?.value)
        }
    }
}
