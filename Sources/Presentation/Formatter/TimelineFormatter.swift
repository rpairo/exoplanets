import Domain

public struct TimelineFormatter: TimelineFormatting {
    public init() { }

    public func format(_ timeline: YearlyPlanetSizeDistribution) -> (headers: String, separator: String, rows: [String]) {
        let yearMargin = 6
        let smallMargin = 6
        let mediumMargin = 7
        let largeMargin = 5

        let yearHeader = "Year".leftAligned(to: yearMargin)
        let smallHeader = "Small".leftAligned(to: smallMargin)
        let mediumHeader = "Medium".leftAligned(to: mediumMargin)
        let largeHeader = "Large".leftAligned(to: largeMargin)
        let headers = "\(yearHeader) \(smallHeader) \(mediumHeader) \(largeHeader)"

        let separator = String(repeating: "-", count: headers.count)

        let sortedTimeline = timeline.sorted { $0.key < $1.key }
        let rows = sortedTimeline.map { year, data in
            let yearStr = String(year).leftAligned(to: yearMargin)
            let smallStr = String(data.small).leftAligned(to: smallMargin)
            let mediumStr = String(data.medium).leftAligned(to: mediumMargin)
            let largeStr = String(data.large).leftAligned(to: largeMargin)
            return "\(yearStr) \(smallStr) \(mediumStr) \(largeStr)"
        }

        return (headers, separator, rows)
    }
}
