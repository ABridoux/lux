import XCTest
@testable import Lux

final class XMLInjectorTests: XCTestCase {

    let stubXmlString =
    """
    <?xml version="1.0>" encoding="UTF-8"?>
    <properties>
        <type>Input</type>
        <inputType>List</inputType>
        <!-- Comment -->
        <isAllowed>true</isAllowed>
    </properties>
    """

    let stubHTMLString =
    """
    &lt;?xml version="1.0&" encoding="UTF-8"?&gt;
    &lt;properties&gt;
        &lt;type&gt;Input&lt;/type&gt;
        &lt;inputType&gt;List&lt;/inputType&gt;
        &lt;!-- Comment --&gt;
        &lt;isAllowed&gt;true&lt;/isAllowed&gt;
    &lt;/properties&gt;
    """

    func testInjectTerminalColor() {
        let tag = XMLCategory.tagDefault.terminalModifier.raw
        let comment = XMLCategory.comment.terminalModifier.raw
        let header = XMLCategory.header.terminalModifier.raw
        let key = XMLCategory.keyDefault.terminalModifier.raw
        let reset = TerminalModifier.resetColors.raw

        let expectedResult =
            """
            \(header)<?xml version="1.0>" encoding="UTF-8"?>\(reset)
            \(tag)<properties>\(reset)
                \(tag)<type>\(reset)\(key)Input\(reset)\(tag)</type>\(reset)
                \(tag)<inputType>\(reset)\(key)List\(reset)\(tag)</inputType>\(reset)
                \(comment)<!-- Comment -->\(reset)
                \(tag)<isAllowed>\(reset)\(key)true\(reset)\(tag)</isAllowed>\(reset)
            \(tag)</properties>\(reset)
            """

        let result = XMLInjector(type: .terminal).inject(in: stubXmlString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let tag = XMLCategory.tagDefault.cssClass
        let comment = XMLCategory.comment.cssClass
        let header = XMLCategory.header.cssClass
        let key = XMLCategory.keyDefault.cssClass

        let expectedResult =
            """
            <span class="\(header)">&lt;?xml version="1.0&" encoding="UTF-8"?&gt;</span>
            <span class="\(tag)">&lt;properties&gt;</span>
                <span class="\(tag)">&lt;type&gt;</span><span class="\(key)">Input</span><span class="\(tag)">&lt;/type&gt;</span>
                <span class="\(tag)">&lt;inputType&gt;</span><span class="\(key)">List</span><span class="\(tag)">&lt;/inputType&gt;</span>
                <span class="\(comment)">&lt;!-- Comment --&gt;</span>
                <span class="\(tag)">&lt;isAllowed&gt;</span><span class="\(key)">true</span><span class="\(tag)">&lt;/isAllowed&gt;</span>
            <span class="\(tag)">&lt;/properties&gt;</span>
            """

        let result = XMLInjector(type: .html).inject(in: stubHTMLString)

        XCTAssertEqual(result, expectedResult)
    }
}
