import XCTest
@testable import Lux

final class XMLInjectorTests: XCTestCase {

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
        let tag = XMLCategory.tagDefault.terminalColor
        let key = XMLCategory.keyDefault.terminalColor
        let reset = Colors.terminalReset

        let expectedResult =
            """
            \(tag)<properties>\(reset)
                \(tag)<type>\(reset)\(key)Input\(reset)\(tag)</type>\(reset)
                \(tag)<inputType>\(reset)\(key)List\(reset)\(tag)</inputType>\(reset)
                \(tag)<isAllowed>\(reset)\(key)true\(reset)\(tag)</isAllowed>\(reset)
            \(tag)</properties>\(reset)
            """

        let result = XMLInjector(type: .plain).inject(in: stubXmlString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let tag = XMLCategory.tagDefault.cssClass
        let key = XMLCategory.keyDefault.cssClass

        let expectedResult =
            """
            <span class="\(tag)">&lt;properties&gt;</span>
                <span class="\(tag)">&lt;type&gt;</span><span class="\(key)">Input</span><span class="\(tag)">&lt;/type&gt;</span>
                <span class="\(tag)">&lt;inputType&gt;</span><span class="\(key)">List</span><span class="\(tag)">&lt;/inputType&gt;</span>
                <span class="\(tag)">&lt;isAllowed&gt;</span><span class="\(key)">true</span><span class="\(tag)">&lt;/isAllowed&gt;</span>
            <span class="\(tag)">&lt;/properties&gt;</span>
            """

        let result = XMLInjector(type: .html).inject(in: stubHTMLString)

        XCTAssertEqual(result, expectedResult)
    }
}
