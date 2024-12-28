enum TestData {
    static let validExoplanet = """
    [
        {
            "PlanetIdentifier": "Valid Planet",
            "TypeFlag": 3,
            "RadiusJpt": 1.5,
            "HostStarTempK": 5000,
            "DiscoveryYear": 2000
        }
    ]
    """.data(using: .utf8)!

    static let emptyJSON = "[]".data(using: .utf8)!

    static let emptyStringsJSON = """
    [
        {
            "PlanetIdentifier": "Test Planet",
            "TypeFlag": "",
            "RadiusJpt": "",
            "HostStarTempK": "",
            "DiscoveryYear": ""
        }
    ]
    """.data(using: .utf8)!

    static let mixedStringsJSON = """
    [
        {
            "PlanetIdentifier": "Mixed Planet",
            "TypeFlag": 3,
            "RadiusJpt": 1.5,
            "HostStarTempK": "",
            "DiscoveryYear": 2000
        }
    ]
    """.data(using: .utf8)!

    static let extremeValuesJSON = """
    [
        {
            "PlanetIdentifier": "Extreme Values",
            "TypeFlag": \(Int.max),
            "HostStarTempK": \(Int.max),
            "DiscoveryYear": \(Int.max)
        }
    ]
    """.data(using: .utf8)!
}
