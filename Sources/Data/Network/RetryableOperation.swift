public protocol RetryableOperation {
    func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T
}
