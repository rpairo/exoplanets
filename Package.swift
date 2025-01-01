// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ExoplanetAnalyzer",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "ExoplanetsTerminal",
            targets: ["ExoplanetsTerminal"]
        ),
        .library(
            name: "exoplanetsAPI",
            targets: ["exoplanetsAPI"]
        )
    ],
    targets: [
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
            dependencies: ["Data"],
            path: "Sources/Infrastructure"
        ),
        .target(
            name: "Presentation",
            dependencies: ["Domain"],
            path: "Sources/Presentation"
        ),
        .target(
            name: "Composition",
            dependencies: ["Data", "Domain", "Presentation", "Infrastructure"],
            path: "Sources/Composition"
        ),
        .target(
            name: "exoplanetsAPI",
            dependencies: ["Composition", "Presentation", "Domain"],
            path: "Sources/API"
        ),
        .executableTarget(
            name: "ExoplanetsTerminal",
            dependencies: ["Composition", "Presentation"],
            path: "Sources/Main"
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["Data", "Domain", "Presentation", "Composition", "Infrastructure"],
            path: "Tests"
        )
    ]
)
