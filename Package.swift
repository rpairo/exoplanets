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
        
        .executableTarget(
            name: "ExoplanetAnalyzer",
            dependencies: ["Data"]),
    ]
)