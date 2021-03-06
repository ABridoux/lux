import XCTest
@testable import Lux

final class JsonInjectorTests: XCTestCase {

    // MARK: - Constants

    let stubJsonString =
    """
    "properties": {
        "Type": "Input",
        "InputType": "List",
        "IsAllowed": true
        "Empty": ""
        "EscapedQuotes": "Escaped \\"Quotes\\""
    }
    """

    func testInjectTerminalColor() {
        let punctuation = JSONCategory.punctuation.terminalModifier.raw
        let keyName = JSONCategory.keyName.terminalModifier.raw
        let keyValue = JSONCategory.keyValue.terminalModifier.raw
        let reset = TerminalModifier.resetColors.raw

        let expectedResult =
            """
            \(punctuation)"\(reset)\(keyName)properties\(reset)\(punctuation)":\(reset) \(punctuation){\(reset)
                \(punctuation)"\(reset)\(keyName)Type\(reset)\(punctuation)":\(reset) \(keyValue)"Input"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(reset)\(keyName)InputType\(reset)\(punctuation)":\(reset) \(keyValue)"List"\(reset)\(punctuation),\(reset)
                \(punctuation)"\(reset)\(keyName)IsAllowed\(reset)\(punctuation)":\(reset) \(keyValue)true\(reset)
                \(punctuation)"\(reset)\(keyName)Empty\(reset)\(punctuation)":\(reset) \(keyValue)""\(reset)
                \(punctuation)"\(reset)\(keyName)EscapedQuotes\(reset)\(punctuation)":\(reset) \(keyValue)"Escaped \\"Quotes\\""\(reset)
            \(punctuation)}\(reset)
            """

        let result = JSONInjector(type: .terminal).inject(in: stubJsonString)

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
            <span class="\(punctuation)">"</span><span class="\(keyName)">Empty</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">""</span>
            <span class="\(punctuation)">"</span><span class="\(keyName)">EscapedQuotes</span><span class="\(punctuation)">":</span> <span class="\(keyValue)">"Escaped \\"Quotes\\""</span>
        <span class="\(punctuation)">}</span>
        """

        let result = JSONInjector(type: .html).inject(in: stubJsonString)

        var index = 0
        for (resultLine, expectedLine) in zip(result.split(separator: "\n"), expectedResult.split(separator: "\n")) {
            if resultLine != expectedLine {
                print("Wrong line: \(index)")
                print(resultLine)
                print(expectedLine)
            }
            index += 1
        }
        XCTAssertEqual(result, expectedResult)
    }
}
