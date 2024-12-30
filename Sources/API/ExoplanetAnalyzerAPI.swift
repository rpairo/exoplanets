import Foundation
import Presentation
import Composition
import Domain

public protocol ExoplanetAnalyzerAPIProtocol {
    func getOrphanPlanets() -> [ExoplanetDTO]?
    func getHottestStarExoplanet() -> ExoplanetDTO?
    func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO?
}

public typealias YearlyPlanetSizeDistributionDTO = [Int: PlanetSizeCountDTO]

public struct PlanetSizeCountDTO: Codable, Equatable {
    public let smallPlanets: Int
    public let mediumPlanets: Int
    public let largePlanets: Int

    public init(smallPlanets: Int, mediumPlanets: Int, largePlanets: Int) {
        self.smallPlanets = smallPlanets
        self.mediumPlanets = mediumPlanets
        self.largePlanets = largePlanets
    }

    // Método para convertir desde el dominio
    public static func from(domain: PlanetSizeCount) -> PlanetSizeCountDTO {
        return PlanetSizeCountDTO(
            smallPlanets: domain.small,
            mediumPlanets: domain.medium,
            largePlanets: domain.large
        )
    }
}

@main
public struct ExoplanetAnalyzerAPI: ExoplanetAnalyzerAPIProtocol {
    private static var presenter: ExoplanetPresenting?

    public static func main() async {
        do {
            let appComposition = AppComposition()
            try await appComposition.build()
            self.presenter = try DIContainer.shared.resolve()
            print("ExoplanetAnalyzerAPI is ready for use.")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    public func getOrphanPlanets() -> [ExoplanetDTO]? {
        guard let planets = Self.presenter?.orphanPlanets() else { return nil }
        return planets.map { ExoplanetMapper.toDTO(from: $0) }
    }

    public func getHottestStarExoplanet() -> ExoplanetDTO? {
        guard let exoplanet = Self.presenter?.hottestStarExoplanet() else { return nil }
        return ExoplanetMapper.toDTO(from: exoplanet)
    }

    public func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO? {
        guard let timeline = Self.presenter?.timeline() else { return nil }
        return timeline.reduce(into: [:]) { result, planetSizeCount in
            result[planetSizeCount.key] = PlanetSizeCountDTO.from(domain: planetSizeCount.value)
        }
    }
}

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
