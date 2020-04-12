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
        let tagColor = PlistCategory.tagDefault.terminalColor
        let keyNameColor = PlistCategory.keyNameDefault.terminalColor
        let keyValueColor = PlistCategory.keyValueDefault.terminalColor
        let resetColor = TextType.terminalResetColor

        let expectedResult =
            """
            \(tagColor)<key>\(resetColor)\(keyNameColor)properties\(resetColor)\(tagColor)</key>\(resetColor)
            \(tagColor)<dict>\(resetColor)
                \(tagColor)<key>\(resetColor)\(keyNameColor)Type\(resetColor)\(tagColor)</key>\(resetColor)
                \(tagColor)<string>\(resetColor)\(keyValueColor)Input\(resetColor)\(tagColor)</string>\(resetColor)
                \(tagColor)<key>\(resetColor)\(keyNameColor)InputType\(resetColor)\(tagColor)</key>\(resetColor)
                \(tagColor)<string>\(resetColor)\(keyValueColor)List\(resetColor)\(tagColor)</string>\(resetColor)
                \(tagColor)<key>\(resetColor)\(keyNameColor)IsAllowed\(resetColor)\(tagColor)</key>\(resetColor)
                \(tagColor)<true/>\(resetColor)
            \(tagColor)</dict>\(resetColor)
            """

        let result = PlistInjector(target: .plainXml).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let expectedResult =
            """
            <span class="plist-tag">&lt;key&gt;</span><span class="plist-key-name">properties</span><span class="plist-tag">&lt;/key&gt;</span>
            <span class="plist-tag">&lt;dict&gt;</span>
                <span class="plist-tag">&lt;key&gt;</span><span class="plist-key-name">Type</span><span class="plist-tag">&lt;/key&gt;</span>
                <span class="plist-tag">&lt;string&gt;</span><span class="plist-key-value">Input</span><span class="plist-tag">&lt;/string&gt;</span>
                <span class="plist-tag">&lt;key&gt;</span><span class="plist-key-name">InputType</span><span class="plist-tag">&lt;/key&gt;</span>
                <span class="plist-tag">&lt;string&gt;</span><span class="plist-key-value">List</span><span class="plist-tag">&lt;/string&gt;</span>
                <span class="plist-tag">&lt;key&gt;</span><span class="plist-key-name">IsAllowed</span><span class="plist-tag">&lt;/key&gt;</span>
                <span class="plist-tag">&lt;true/&gt;</span>
            <span class="plist-tag">&lt;/dict&gt;</span>
            """

        let result = PlistInjector(target: .htmlXml).inject(in: stubHtmlPlistString)

        XCTAssertEqual(result, expectedResult)
    }
}
