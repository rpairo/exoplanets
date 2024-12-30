public protocol ApplicationFlow {
    func build() async throws
    func start() throws
}
