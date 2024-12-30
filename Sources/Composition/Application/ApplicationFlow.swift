public protocol ApplicationFlow {
    func build() throws
    func start() async throws
}
