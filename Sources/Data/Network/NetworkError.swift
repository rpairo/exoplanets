import Foundation

public enum NetworkError: Error, LocalizedError, Equatable {
    case invalidResponse
    case badStatus(Int)
    case invalidData
    case unableToComplete

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response"
        case .badStatus(let code):
            return "The server returned an error status: \(code)"
        case .invalidData:
            return "The data received was invalid"
        case .unableToComplete:
            return "The operation could not be completed"
        }
    }

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidResponse, .invalidResponse),
             (.invalidData, .invalidData),
             (.unableToComplete, .unableToComplete):
            return true
        case let (.badStatus(code1), .badStatus(code2)):
            return code1 == code2
        default:
            return false
        }
    }
}
