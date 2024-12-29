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
            targets: ["Main"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Configuration",
            dependencies: [],
            path: "Sources/Configuration"
        ),
        .target(
            name: "Domain",
            dependencies: [],
            path: "Sources/Domain"
        ),
        .target(
            name: "Data",
            dependencies: ["Domain"],
            path: "Sources/Data"
        ),
        .target(
            name: "Infrastructure",
            dependencies: ["Configuration", "Data"],
            path: "Sources/Infrastructure"
        ),
        .target(
            name: "Presentation",
            dependencies: ["Domain"],
            path: "Sources/Presentation"
        ),
        .target(
            name: "Composition",
            dependencies: ["Data", "Domain", "Presentation", "Infrastructure", "Configuration"],
            path: "Sources/Composition"
        ),
        .executableTarget(
            name: "Main",
            dependencies: ["Composition", "Configuration"],
            path: "Sources/Main"
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["Data", "Domain", "Presentation", "Composition", "Infrastructure", "Configuration"],
            path: "Tests"
        )
    ]
)
