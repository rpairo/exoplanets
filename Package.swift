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
        .target(
            name: "Domain",
            dependencies: []),
        
        .target(
            name: "Data",
            dependencies: ["Domain"]),
        
        .target(
            name: "UseCase",
            dependencies: ["Domain", "Data"]),
        
        .target(
            name: "Composition",
            dependencies: ["UseCase"]),
        
        .executableTarget(
            name: "ExoplanetAnalyzer",
            dependencies: ["UseCase", "Composition"]),
    ]
)