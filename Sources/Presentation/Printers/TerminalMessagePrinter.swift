public struct TerminalMessagePrinter: MessagePrinter {
    private let output: (String) -> Void

    public init(output: @escaping (String) -> Void = { print($0) }) {
        self.output = output
    }

    public func printMessage(_ message: String) {
        output(message)
    }
}
