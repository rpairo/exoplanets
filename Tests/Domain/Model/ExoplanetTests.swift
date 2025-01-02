import XCTest
@testable import Domain

final class ExoplanetTests: XCTestCase {
    func test_exoplanet_initialization_withValidData_shouldSucceed() {
        let exoplanet = Exoplanet(
            planetIdentifier: "Earth 2.0",
            typeFlag: 1,
            planetaryMassJpt: 1.0,
            radiusJpt: 1.1,
            periodDays: 365.0,
            semiMajorAxisAU: 1.0,
            inclinationDeg: 0.0,
            discoveryMethod: "Transit",
            discoveryYear: 2022,
            lastUpdated: "2025-01-01",
            rightAscension: "00h 00m 00s",
            declination: "+00° 00′ 00″",
            distFromSunParsec: "10",
            hostStarMassSlrMass: 1.0,
            hostStarRadiusSlrRad: 1.0,
            hostStarMetallicity: 0.0,
            hostStarTempK: 6000
        )

        XCTAssertEqual(exoplanet.planetIdentifier, "Earth 2.0")
        XCTAssertEqual(exoplanet.discoveryMethod, "Transit")
        XCTAssertEqual(exoplanet.discoveryYear, 2022)
    }

    func test_exoplanet_decoding_withCompleteData_shouldSucceed() throws {
        let jsonData = """
        {
            "PlanetIdentifier": "Earth 2.0",
            "TypeFlag": 1,
            "PlanetaryMassJpt": 1.0,
            "RadiusJpt": 1.1,
            "PeriodDays": 365.0,
            "SemiMajorAxisAU": 1.0,
            "DiscoveryMethod": "Transit",
            "DiscoveryYear": 2022
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Exoplanet.self, from: jsonData)

        XCTAssertEqual(decoded.planetIdentifier, "Earth 2.0")
        XCTAssertEqual(decoded.discoveryMethod, "Transit")
        XCTAssertEqual(decoded.discoveryYear, 2022)
    }

    func test_exoplanet_decoding_withMissingFields_shouldSucceed() throws {
        let jsonData = """
        {
            "PlanetIdentifier": "Unknown"
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Exoplanet.self, from: jsonData)

        XCTAssertNil(decoded.typeFlag)
        XCTAssertNil(decoded.discoveryYear)
        XCTAssertNil(decoded.radiusJpt)
        XCTAssertNil(decoded.hostStarTempK)
        XCTAssertNil(decoded.declination)
        XCTAssertNil(decoded.discoveryMethod)
        XCTAssertEqual(decoded.planetIdentifier, "Unknown")
    }

    func test_exoplanet_decoding_withNumericPropertyWithEmptyStringValue_shouldSucceed() throws {
        let jsonData = """
        {
            "TypeFlag": "",
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Exoplanet.self, from: jsonData)

        XCTAssertNil(decoded.typeFlag)
    }

    func test_exoplanet_decoding_withStringPropertyWithEmptyStringValue_shouldSucceed() throws {
        let jsonData = """
        {
            "PlanetIdentifier": "",
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Exoplanet.self, from: jsonData)

        XCTAssertNil(decoded.planetIdentifier)
    }
}
