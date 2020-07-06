import XCTest
@testable import Lux

final class PlistInjectorTests: XCTestCase {

    // MARK: - Constants

    let stubPlistString =
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Type</key>
        <string>Input</string>
        <key>InputType</key>
        <string>List</string>
        <!-- Comment -->
        <key>IsAllowed</key>
        <true/>
    </dict>
    </plist>
    """

    let stubHtmlPlistString =
        """
        &lt;?xml version="1.0" encoding="UTF-8"?&gt;
        &lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;
        &lt;plist version="1.0"&gt;
        &lt;dict&gt;
            &lt;key&gt;Type&lt;/key&gt;
            &lt;string&gt;Input&lt;/string&gt;
            &lt;key&gt;InputType&lt;/key&gt;
            &lt;string&gt;List&lt;/string&gt;
            &lt;!-- Comment --&gt;
            &lt;key&gt;IsAllowed&lt;/key&gt;
            &lt;true/&gt;
        &lt;/dict&gt;
        &lt;/plist&gt;
        """

    func testInjectTerminalColor() {
        let tag = PlistCategory.tagDefault.terminalModifier.raw
        let keyName = PlistCategory.keyNameDefault.terminalModifier.raw
        let keyValue = PlistCategory.keyValueDefault.terminalModifier.raw
        let comment = PlistCategory.comment.terminalModifier.raw
        let header = PlistCategory.header.terminalModifier.raw
        let reset = TerminalModifier.resetColors.raw

        let expectedResult =
            """
            \(header)<?xml version="1.0" encoding="UTF-8"?>\(reset)
            \(header)<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\(reset)
            \(header)<plist version="1.0">\(reset)
            \(tag)<dict>\(reset)
                \(tag)<key>\(reset)\(keyName)Type\(reset)\(tag)</key>\(reset)
                \(tag)<string>\(reset)\(keyValue)Input\(reset)\(tag)</string>\(reset)
                \(tag)<key>\(reset)\(keyName)InputType\(reset)\(tag)</key>\(reset)
                \(tag)<string>\(reset)\(keyValue)List\(reset)\(tag)</string>\(reset)
                \(comment)<!-- Comment -->\(reset)
                \(tag)<key>\(reset)\(keyName)IsAllowed\(reset)\(tag)</key>\(reset)
                \(tag)<true/>\(reset)
            \(tag)</dict>\(reset)
            \(header)</plist>\(reset)
            """

        let result = PlistInjector(type: .terminal).inject(in: stubPlistString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let tag = PlistCategory.tagDefault.cssClass
        let keyName = PlistCategory.keyNameDefault.cssClass
        let comment = PlistCategory.comment.cssClass
        let header = PlistCategory.header.cssClass
        let keyValue = PlistCategory.keyValueDefault.cssClass

        let expectedResult =
            """
            <span class="\(header)">&lt;?xml version="1.0" encoding="UTF-8"?&gt;</span>
            <span class="\(header)">&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;</span>
            <span class="\(header)">&lt;plist version="1.0"&gt;</span>
            <span class="\(tag)">&lt;dict&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">Type</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;string&gt;</span><span class="\(keyValue)">Input</span><span class="\(tag)">&lt;/string&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">InputType</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;string&gt;</span><span class="\(keyValue)">List</span><span class="\(tag)">&lt;/string&gt;</span>
                <span class="\(comment)">&lt;!-- Comment --&gt;</span>
                <span class="\(tag)">&lt;key&gt;</span><span class="\(keyName)">IsAllowed</span><span class="\(tag)">&lt;/key&gt;</span>
                <span class="\(tag)">&lt;true/&gt;</span>
            <span class="\(tag)">&lt;/dict&gt;</span>
            <span class="\(header)">&lt;/plist&gt;</span>
            """

        let result = PlistInjector(type: .html).inject(in: stubHtmlPlistString)

        XCTAssertEqual(result, expectedResult)
    }
}
