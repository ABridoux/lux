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
        let punctuation = JSONCategory.punctuation.terminalColor
        let keyName = JSONCategory.keyName.terminalColor
        let keyValue = JSONCategory.keyValue.terminalColor
        let reset = TerminalColor.reset

        let expectedResult =
            """
            \(punctuation)"\(keyName)properties\(punctuation)":\(reset) \(punctuation){\(reset)
                \(punctuation)"\(keyName)Type\(punctuation)":\(reset) \(keyValue)"Input"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(keyName)InputType\(punctuation)":\(reset) \(keyValue)"List"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(keyName)IsAllowed\(punctuation)":\(reset) \(keyValue)true\(reset)
            \(punctuation)}\(reset)
            """

        let result = JSONInjector(type: .plain).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let punctuation = JSONCategory.punctuation.cssClass
        let keyName = JSONCategory.keyName.cssClass
        let keyValue = JSONCategory.keyValue.cssClass

        let expectedResult =
        """
        <span class="\(punctuation)">"</span><span class="\(keyName)">properties</span><span class="\(punctuation)">":</span> <span class="\(punctuation)">{</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">Type</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">"Input"</span><span class="\(punctuation)">,</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">InputType</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">"List"</span><span class="\(punctuation)">,</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">IsAllowed</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">true</span>
        <span class="\(punctuation)">}</span>
        """

        let result = JSONInjector(type: .html).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }
}
