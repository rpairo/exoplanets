@testable import Presentation

final class MockPrinter: MessagePrinter {
    var printedMessages: [String] = []

    func printMessage(_ message: String) {
        printedMessages.append(message)
    }
}
