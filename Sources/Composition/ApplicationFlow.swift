import Configuration

public protocol ApplicationFlow {
    func build(for environment: Environment)
    func start() async throws
}
