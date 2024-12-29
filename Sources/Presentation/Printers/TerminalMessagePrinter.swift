public struct TerminalMessagePrinter: MessagePrinter {
    public init() {}

    public func printMessage(_ message: String) {
        print(message)
    }
}
