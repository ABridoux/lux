import XCTest
@testable import Lux

final class PlistInjectorTests: XCTestCase {

    // MARK: - Constants

    let stubPlistString =
    """
    <key>properties</key>
    <dict>
        <key>Type</key>
        <string>Input</string>
        <key>InputType</key>
        <string>List</string>
        <key>IsAllowed</key>
        <true/>
    </dict>
    """

    let stubHtmlPlistString =
        """
        &lt;key&gt;properties&lt;/key&gt;
        &lt;dict&gt;
            &lt;key&gt;Type&lt;/key&gt;
            &lt;string&gt;Input&lt;/string&gt;
            &lt;key&gt;InputType&lt;/key&gt;
            &lt;string&gt;List&lt;/string&gt;
            &lt;key&gt;IsAllowed&lt;/key&gt;
            &lt;true/&gt;
        &lt;/dict&gt;
        """

    func testInjectTerminalColor() {
        let tag = PlistCategory.tagDefault.terminalColor
        let keyName = PlistCategory.keyNameDefault.terminalColor
        let keyValue = PlistCategory.keyValueDefault.terminalColor
        let reset = TerminalColor.reset

        let expectedResult =
            """
            \(tag)<key>\(reset)\(keyName)properties\(reset)\(tag)</key>\(reset)
            \(tag)<dict>\(reset)
                \(tag)<key>\(reset)\(keyName)Type\(reset)\(tag)</key>\(reset)
                \(tag)<string>\(reset)\(keyValue)Input\(reset)\(tag)</string>\(reset)
                \(tag)<key>\(reset)\(keyName)InputType\(reset)\(tag)</key>\(reset)
                \(tag)<string>\(reset)\(keyValue)List\(reset)\(tag)</string>\(reset)
                \(tag)<key>\(reset)\(keyName)IsAllowed\(reset)\(tag)</key>\(reset)
                \(tag)<true/>\(reset)
            \(tag)</dict>\(reset)
            """

        let result = PlistInjector(type: .plain).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let tag = PlistCategory.tagDefault.cssClass
        let keyName = PlistCategory.keyNameDefault.cssClass
        let keyValue = PlistCategory.keyValueDefault.cssClass

        let expectedResult =
            """
            <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">properties</span><span class="\(tag)">&lt;/key&gt;</span>
            <span class="\(tag)">&lt;dict&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">Type</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;string&gt;</span><span class="\(keyValue)">Input</span><span class="\(tag)">&lt;/string&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">InputType</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;string&gt;</span><span class="\(keyValue)">List</span><span class="\(tag)">&lt;/string&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">IsAllowed</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;true/&gt;</span>
            <span class="\(tag)">&lt;/dict&gt;</span>
            """

        let result = PlistInjector(type: .html).inject(in: stubHtmlPlistString)

        XCTAssertEqual(result, expectedResult)
    }
}
