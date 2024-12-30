import Domain

struct ExoplanetMapper {
    static func toDTO(from exoplanet: Exoplanet) -> ExoplanetDTO {
        return ExoplanetDTO(
            planetIdentifier: exoplanet.planetIdentifier,
            typeFlag: exoplanet.typeFlag,
            planetaryMassJpt: exoplanet.planetaryMassJpt,
            radiusJpt: exoplanet.radiusJpt,
            periodDays: exoplanet.periodDays,
            semiMajorAxisAU: exoplanet.semiMajorAxisAU,
            eccentricity: exoplanet.eccentricity,
            periastronDeg: exoplanet.periastronDeg,
            longitudeDeg: exoplanet.longitudeDeg,
            ascendingNodeDeg: exoplanet.ascendingNodeDeg,
            inclinationDeg: exoplanet.inclinationDeg,
            surfaceTempK: exoplanet.surfaceTempK,
            ageGyr: exoplanet.ageGyr,
            discoveryMethod: exoplanet.discoveryMethod,
            discoveryYear: exoplanet.discoveryYear,
            lastUpdated: exoplanet.lastUpdated,
            rightAscension: exoplanet.rightAscension,
            declination: exoplanet.declination,
            distFromSunParsec: exoplanet.distFromSunParsec,
            hostStarMassSlrMass: exoplanet.hostStarMassSlrMass,
            hostStarRadiusSlrRad: exoplanet.hostStarRadiusSlrRad,
            hostStarMetallicity: exoplanet.hostStarMetallicity,
            hostStarTempK: exoplanet.hostStarTempK,
            hostStarAgeGyr: exoplanet.hostStarAgeGyr
        )
    }
}
