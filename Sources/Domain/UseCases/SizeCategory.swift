enum SizeCategory {
    case small
    case medium
    case large

    static let smallThreshold = 1.0
    static let mediumThreshold = 2.0

    init(radius: Double) {
        switch radius {
        case 0..<Self.smallThreshold:
            self = .small
        case Self.smallThreshold..<Self.mediumThreshold:
            self = .medium
        default:
            self = .large
        }
    }

    var sizeCount: PlanetSizeCount {
        switch self {
        case .small:
            return PlanetSizeCount(small: 1, medium: 0, large: 0)
        case .medium:
            return PlanetSizeCount(small: 0, medium: 1, large: 0)
        case .large:
            return PlanetSizeCount(small: 0, medium: 0, large: 1)
        }
    }
}
