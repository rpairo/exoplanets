import XCTest
import Presentation

final class TerminalMessagePrinterTests: XCTestCase {
    func test_printMessage_withValidMessage_shouldCallOutput() {
        var capturedOutput: String?
        let messagePrinter = TerminalMessagePrinter(output: { capturedOutput = $0 })
        let message = "Hello, Exoplanets!"

        messagePrinter.printMessage(message)

        XCTAssertEqual(capturedOutput, message, "The captured output should match the input message")
    }

    func test_printMessage_withEmptyMessage_shouldCallOutputWithEmptyString() {
        var capturedOutput: String?
        let messagePrinter = TerminalMessagePrinter(output: { capturedOutput = $0 })
        let message = ""

        messagePrinter.printMessage(message)

        XCTAssertEqual(capturedOutput, message, "The captured output should be an empty string")
    }

    func test_printMessage_withMultilineMessage_shouldCallOutputWithAllLines() {
        var capturedOutput: String?
        let messagePrinter = TerminalMessagePrinter(output: { capturedOutput = $0 })
        let message = """
        Line 1
        Line 2
        Line 3
        """

        messagePrinter.printMessage(message)

        XCTAssertEqual(capturedOutput, message, "The captured output should match the multiline input")
    }
}
