import Foundation
import Composition

public struct ExoplanetAnalyzer {
    private let useCases: ExoplanetUseCases
    
    public init(useCases: ExoplanetUseCases) {
        self.useCases = useCases
    }
    
    public func run() {
        Task {
            do {
                // 1. Orphan planet counter
                let orphanCount = try await useCases.countOrphanPlanets()
                print("Número de planetas huérfanos (sin estrella): \(orphanCount)")
                
                // 2. Hottest star orbiting planet
                if let planet = try await useCases.findPlanetOrbitingHottestStar() {
                    print("Planeta que orbita la estrella más caliente: \(planet)")
                } else {
                    print("Planeta que orbita la estrella más caliente: N/A")
                }
                
                // 3. Timeline creation
                let timeline = try await useCases.createDiscoveryTimelineBySize()
                print("\nLínea de tiempo de descubrimientos (año => pequeño, mediano, grande):")
                for year in timeline.keys.sorted() {
                    if let counts = timeline[year] {
                        print("\(year) => pequeño: \(counts.small), mediano: \(counts.medium), grande: \(counts.large)")
                    }
                }
                
                exit(0)
            } catch {
                print("Error: \(error.localizedDescription)")
                exit(1)
            }
        }
        
        RunLoop.main.run()
    }
}

let appBuilder = AppBuilder()
let analyzer = appBuilder.build()
analyzer.run()