import XCTest
@testable import Lux

final class XmlInjectorTests: XCTestCase {

    let stubXmlString =
    """
    <properties>
        <type>Input</type>
        <inputType>List</inputType>
        <isAllowed>true</isAllowed>
    </properties>
    """

    let stubHTMLString =
       """
       &lt;properties&gt;
           &lt;type&gt;Input&lt;/type&gt;
           &lt;inputType&gt;List&lt;/inputType&gt;
           &lt;isAllowed&gt;true&lt;/isAllowed&gt;
       &lt;/properties&gt;
       """

    func testInjectTerminalColor() {
        let tagColor = XmlCategory.tagDefault.terminalColor
        let keyColor = XmlCategory.keyDefault.terminalColor
        let resetColor = TextType.terminalResetColor

        let expectedResult =
            """
            \(tagColor)<properties>\(resetColor)
                \(tagColor)<type>\(resetColor)\(keyColor)Input\(resetColor)\(tagColor)</type>\(resetColor)
                \(tagColor)<inputType>\(resetColor)\(keyColor)List\(resetColor)\(tagColor)</inputType>\(resetColor)
                \(tagColor)<isAllowed>\(resetColor)\(keyColor)true\(resetColor)\(tagColor)</isAllowed>\(resetColor)
            \(tagColor)</properties>\(resetColor)
            """

        let result = XmlInjector(type: .plain).inject(in: stubXmlString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let expectedResult =
            """
            <span class="xml-tag">&lt;properties&gt;</span>
                <span class="xml-tag">&lt;type&gt;</span><span class="xml-key">Input</span><span class="xml-tag">&lt;/type&gt;</span>
                <span class="xml-tag">&lt;inputType&gt;</span><span class="xml-key">List</span><span class="xml-tag">&lt;/inputType&gt;</span>
                <span class="xml-tag">&lt;isAllowed&gt;</span><span class="xml-key">true</span><span class="xml-tag">&lt;/isAllowed&gt;</span>
            <span class="xml-tag">&lt;/properties&gt;</span>
            """

        let result = XmlInjector(type: .html).inject(in: stubHTMLString)

        XCTAssertEqual(result, expectedResult)
    }
}
