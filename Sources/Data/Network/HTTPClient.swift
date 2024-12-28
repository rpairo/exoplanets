import Foundation
import Domain

public protocol HTTPClient {
    func get(from url: URL) async throws -> Data
}
