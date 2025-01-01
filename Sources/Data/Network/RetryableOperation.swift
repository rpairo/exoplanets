public protocol RetryableOperation {
    var configuration: RetryConfiguration { get set }
    func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T
}
