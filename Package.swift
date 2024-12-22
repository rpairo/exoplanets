// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ExoplanetAnalyzer",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "ExoplanetAnalyzer",
            targets: ["ExoplanetAnalyzer"]),
    ],
    dependencies: [],
    targets: [
        // Capa de Dominio
        .target(
            name: "Domain",
            dependencies: []),
        
        // Capa de Presentación (Ejecutable)
        .executableTarget(
            name: "ExoplanetAnalyzer",
            dependencies: ["Domain"]),
    ]
)