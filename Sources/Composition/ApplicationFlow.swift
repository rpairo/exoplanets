import Configuration

public protocol ApplicationFlow {
    func build(for environment: Environment) throws
    func start() async throws
}
