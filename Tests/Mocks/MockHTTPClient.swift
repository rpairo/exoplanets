import Foundation
import Data

final class MockHTTPClient: HTTPClient {
    private(set) var getCallCount = 0
    private(set) var lastGetCall: Date?
    private let result: Result<Data, Error>

    init(result: Result<Data, Error>) {
        self.result = result
    }

    func get(from url: URL) async throws -> Data {
        getCallCount += 1
        lastGetCall = Date()

        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

enum NetworkBehavior {
    case success(Data)
    case failure(Error)
}

extension Result where Success == Data {
    static func from(_ behavior: NetworkBehavior) -> Result<Data, Error> {
        switch behavior {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}
