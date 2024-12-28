public struct Exoplanet: Codable {
    public let planetIdentifier: String?
    public let typeFlag: Int?
    public let planetaryMassJpt: Double?
    public let radiusJpt: Double?
    public let periodDays: Double?
    public let semiMajorAxisAU: Double?
    public let eccentricity: String?
    public let periastronDeg: String?
    public let longitudeDeg: String?
    public let ascendingNodeDeg: String?
    public let inclinationDeg: Double?
    public let surfaceTempK: String?
    public let ageGyr: String?
    public let discoveryMethod: String?
    public let discoveryYear: Int?
    public let lastUpdated: String?
    public let rightAscension: String?
    public let declination: String?
    public let distFromSunParsec: String?
    public let hostStarMassSlrMass: Double?
    public let hostStarRadiusSlrRad: Double?
    public let hostStarMetallicity: Double?
    public let hostStarTempK: Int?
    public let hostStarAgeGyr: String?

    enum CodingKeys: String, CodingKey {
        case planetIdentifier = "PlanetIdentifier"
        case typeFlag = "TypeFlag"
        case planetaryMassJpt = "PlanetaryMassJpt"
        case radiusJpt = "RadiusJpt"
        case periodDays = "PeriodDays"
        case semiMajorAxisAU = "SemiMajorAxisAU"
        case eccentricity = "Eccentricity"
        case periastronDeg = "PeriastronDeg"
        case longitudeDeg = "LongitudeDeg"
        case ascendingNodeDeg = "AscendingNodeDeg"
        case inclinationDeg = "InclinationDeg"
        case surfaceTempK = "SurfaceTempK"
        case ageGyr = "AgeGyr"
        case discoveryMethod = "DiscoveryMethod"
        case discoveryYear = "DiscoveryYear"
        case lastUpdated = "LastUpdated"
        case rightAscension = "RightAscension"
        case declination = "Declination"
        case distFromSunParsec = "DistFromSunParsec"
        case hostStarMassSlrMass = "HostStarMassSlrMass"
        case hostStarRadiusSlrRad = "HostStarRadiusSlrRad"
        case hostStarMetallicity = "HostStarMetallicity"
        case hostStarTempK = "HostStarTempK"
        case hostStarAgeGyr = "HostStarAgeGyr"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        planetIdentifier = try container.decodeIfPresentString(forKey: .planetIdentifier)
        typeFlag = try container.decodeIfPresentInt(forKey: .typeFlag)
        planetaryMassJpt = try container.decodeIfPresentDouble(forKey: .planetaryMassJpt)
        radiusJpt = try container.decodeIfPresentDouble(forKey: .radiusJpt)
        periodDays = try container.decodeIfPresentDouble(forKey: .periodDays)
        semiMajorAxisAU = try container.decodeIfPresentDouble(forKey: .semiMajorAxisAU)
        eccentricity = try container.decodeIfPresentString(forKey: .eccentricity)
        periastronDeg = try container.decodeIfPresentString(forKey: .periastronDeg)
        longitudeDeg = try container.decodeIfPresentString(forKey: .longitudeDeg)
        ascendingNodeDeg = try container.decodeIfPresentString(forKey: .ascendingNodeDeg)
        inclinationDeg = try container.decodeIfPresentDouble(forKey: .inclinationDeg)
        surfaceTempK = try container.decodeIfPresentString(forKey: .surfaceTempK)
        ageGyr = try container.decodeIfPresentString(forKey: .ageGyr)
        discoveryMethod = try container.decodeIfPresentString(forKey: .discoveryMethod)
        discoveryYear = try container.decodeIfPresentInt(forKey: .discoveryYear)
        lastUpdated = try container.decodeIfPresentString(forKey: .lastUpdated)
        rightAscension = try container.decodeIfPresentString(forKey: .rightAscension)
        declination = try container.decodeIfPresentString(forKey: .declination)
        distFromSunParsec = try container.decodeIfPresentString(forKey: .distFromSunParsec)
        hostStarMassSlrMass = try container.decodeIfPresentDouble(forKey: .hostStarMassSlrMass)
        hostStarRadiusSlrRad = try container.decodeIfPresentDouble(forKey: .hostStarRadiusSlrRad)
        hostStarMetallicity = try container.decodeIfPresentDouble(forKey: .hostStarMetallicity)
        hostStarTempK = try container.decodeIfPresentInt(forKey: .hostStarTempK)
        hostStarAgeGyr = try container.decodeIfPresentString(forKey: .hostStarAgeGyr)
    }

    public init(
        planetIdentifier: String? = nil,
        typeFlag: Int? = nil,
        planetaryMassJpt: Double? = nil,
        radiusJpt: Double? = nil,
        periodDays: Double? = nil,
        semiMajorAxisAU: Double? = nil,
        eccentricity: String? = nil,
        periastronDeg: String? = nil,
        longitudeDeg: String? = nil,
        ascendingNodeDeg: String? = nil,
        inclinationDeg: Double? = nil,
        surfaceTempK: String? = nil,
        ageGyr: String? = nil,
        discoveryMethod: String? = nil,
        discoveryYear: Int? = nil,
        lastUpdated: String? = nil,
        rightAscension: String? = nil,
        declination: String? = nil,
        distFromSunParsec: String? = nil,
        hostStarMassSlrMass: Double? = nil,
        hostStarRadiusSlrRad: Double? = nil,
        hostStarMetallicity: Double? = nil,
        hostStarTempK: Int? = nil,
        hostStarAgeGyr: String? = nil
    ) {
        self.planetIdentifier = planetIdentifier
        self.typeFlag = typeFlag
        self.planetaryMassJpt = planetaryMassJpt
        self.radiusJpt = radiusJpt
        self.periodDays = periodDays
        self.semiMajorAxisAU = semiMajorAxisAU
        self.eccentricity = eccentricity
        self.periastronDeg = periastronDeg
        self.longitudeDeg = longitudeDeg
        self.ascendingNodeDeg = ascendingNodeDeg
        self.inclinationDeg = inclinationDeg
        self.surfaceTempK = surfaceTempK
        self.ageGyr = ageGyr
        self.discoveryMethod = discoveryMethod
        self.discoveryYear = discoveryYear
        self.lastUpdated = lastUpdated
        self.rightAscension = rightAscension
        self.declination = declination
        self.distFromSunParsec = distFromSunParsec
        self.hostStarMassSlrMass = hostStarMassSlrMass
        self.hostStarRadiusSlrRad = hostStarRadiusSlrRad
        self.hostStarMetallicity = hostStarMetallicity
        self.hostStarTempK = hostStarTempK
        self.hostStarAgeGyr = hostStarAgeGyr
    }
}

extension Exoplanet: Equatable {
    public static func == (lhs: Exoplanet, rhs: Exoplanet) -> Bool {
        lhs.planetIdentifier == rhs.planetIdentifier &&
        lhs.typeFlag == rhs.typeFlag &&
        lhs.planetaryMassJpt == rhs.planetaryMassJpt &&
        lhs.radiusJpt == rhs.radiusJpt &&
        lhs.periodDays == rhs.periodDays &&
        lhs.semiMajorAxisAU == rhs.semiMajorAxisAU &&
        lhs.eccentricity == rhs.eccentricity &&
        lhs.periastronDeg == rhs.periastronDeg &&
        lhs.longitudeDeg == rhs.longitudeDeg &&
        lhs.ascendingNodeDeg == rhs.ascendingNodeDeg &&
        lhs.inclinationDeg == rhs.inclinationDeg &&
        lhs.surfaceTempK == rhs.surfaceTempK &&
        lhs.ageGyr == rhs.ageGyr &&
        lhs.discoveryMethod == rhs.discoveryMethod &&
        lhs.discoveryYear == rhs.discoveryYear &&
        lhs.lastUpdated == rhs.lastUpdated &&
        lhs.rightAscension == rhs.rightAscension &&
        lhs.declination == rhs.declination &&
        lhs.distFromSunParsec == rhs.distFromSunParsec &&
        lhs.hostStarMassSlrMass == rhs.hostStarMassSlrMass &&
        lhs.hostStarRadiusSlrRad == rhs.hostStarRadiusSlrRad &&
        lhs.hostStarMetallicity == rhs.hostStarMetallicity &&
        lhs.hostStarTempK == rhs.hostStarTempK &&
        lhs.hostStarAgeGyr == rhs.hostStarAgeGyr
    }
}

extension KeyedDecodingContainer {
    func decodeIfPresentDouble(forKey key: K) throws -> Double? {
        if let _ = try? decodeIfPresent(String.self, forKey: key) {
            return nil // If it's a String, return nil
        }
        return try? decodeIfPresent(Double.self, forKey: key)
    }

    func decodeIfPresentInt(forKey key: K) throws -> Int? {
        if let _ = try? decodeIfPresent(String.self, forKey: key) {
            return nil // If it's a String, return nil
        }
        return try? decodeIfPresent(Int.self, forKey: key)
    }

    func decodeIfPresentString(forKey key: K) throws -> String? {
        if let rawValue = try? decodeIfPresent(String.self, forKey: key) {
            return rawValue.isEmpty ? nil : rawValue
        }
        return nil
    }
}
