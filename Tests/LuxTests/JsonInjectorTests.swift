import XCTest
@testable import Lux

final class JsonInjectorTests: XCTestCase {

    // MARK: - Constants

    let stubPlistString =
    """
    "properties": {
        "Type": "Input",
        "InputType": "List",
        "IsAllowed": true
    }
    """

    func testInjectTerminalColor() {
        let punctuation = JsonCategory.punctuation.terminalColor
        let keyName = JsonCategory.keyName.terminalColor
        let keyValue = JsonCategory.keyValue.terminalColor
        let reset = JsonCategory.terminalResetColor

        let expectedResult =
            """
            \(punctuation)"\(keyName)properties\(punctuation)":\(reset) \(punctuation){\(reset)
                \(punctuation)"\(keyName)Type\(punctuation)":\(reset) \(keyValue)"Input"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(keyName)InputType\(punctuation)":\(reset) \(keyValue)"List"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(keyName)IsAllowed\(punctuation)":\(reset) \(keyValue)true\(reset)
            \(punctuation)}\(reset)
            """

        let result = JsonInjector(type: .plain).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let punctuation = JsonCategory.punctuation.cssClass
        let keyName = JsonCategory.keyName.cssClass
        let keyValue = JsonCategory.keyValue.cssClass

        let expectedResult =
        """
        <span class="\(punctuation)">"</span><span class="\(keyName)">properties</span><span class="\(punctuation)">":</span> <span class="\(punctuation)">{</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">Type</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">"Input"</span><span class="\(punctuation)">,</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">InputType</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">"List"</span><span class="\(punctuation)">,</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">IsAllowed</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">true</span>
        <span class="\(punctuation)">}</span>
        """

        let result = JsonInjector(type: .html).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }
}
