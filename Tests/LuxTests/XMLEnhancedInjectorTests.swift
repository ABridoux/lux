import XCTest
@testable import Lux

final class XMLEnhancedInjectorTests: XCTestCase {

    let stubXmlString =
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <properties>
        <type>Input</type>
        <inputType>List</inputType>
        <!-- Comment -->
        <isAllowed>true</isAllowed>
    </properties>
    """

    let stubHTMLString =
    """
    &lt;?xml version="1.0" encoding="UTF-8"?&gt;
    &lt;properties&gt;
        &lt;type&gt;Input&lt;/type&gt;
        &lt;inputType&gt;List&lt;/inputType&gt;
        &lt;!-- Comment --&gt;
        &lt;isAllowed&gt;true&lt;/isAllowed&gt;
    &lt;/properties&gt;
    """

    func testInjectTerminalColor() {
        let openingTag = XMLEnhancedCategory.openingTagDefault.terminalColor
        let closingTag = XMLEnhancedCategory.closingTagDefault.terminalColor
        let punctuation = XMLEnhancedCategory.punctuation.terminalColor
        let comment = XMLEnhancedCategory.comment.terminalColor
        let header = XMLEnhancedCategory.header.terminalColor
        let key = XMLEnhancedCategory.keyDefault.terminalColor
        let reset = Colors.terminalReset

        let expectedResult =
            """
            \(header)<?xml version="1.0" encoding="UTF-8"?>\(reset)
            \(punctuation)<\(reset)\(openingTag)properties\(reset)\(punctuation)>\(reset)
                \(punctuation)<\(reset)\(openingTag)type\(reset)\(punctuation)>\(reset)\(key)Input\(reset)\(closingTag)</type>\(reset)
                \(punctuation)<\(reset)\(openingTag)inputType\(reset)\(punctuation)>\(reset)\(key)List\(reset)\(closingTag)</inputType>\(reset)
                \(comment)<!-- Comment -->\(reset)
                \(punctuation)<\(reset)\(openingTag)isAllowed\(reset)\(punctuation)>\(reset)\(key)true\(reset)\(closingTag)</isAllowed>\(reset)
            \(closingTag)</properties>\(reset)
            """

        let result = XMLEnhancedInjector(type: .plain).inject(in: stubXmlString)

        XCTAssertEqual(result, expectedResult)
    }

    func testInjectCssClasses() {
        let openingTag = #"<span class="\#(XMLEnhancedCategory.openingTagDefault.cssClass)">"#
        let closingTag = #"<span class="\#(XMLEnhancedCategory.closingTagDefault.cssClass)">"#
        let punctuation = #"<span class="\#(XMLEnhancedCategory.punctuation.cssClass)">"#
        let comment = #"<span class="\#(XMLEnhancedCategory.comment.cssClass)">"#
        let header = #"<span class="\#(XMLEnhancedCategory.header.cssClass)">"#
        let key = #"<span class="\#(XMLEnhancedCategory.keyDefault.cssClass)">"#
        let reset = "</span>"

        let expectedResult =
            """
            \(header)&lt;?xml version="1.0" encoding="UTF-8"?&gt;\(reset)
            \(punctuation)&lt;\(reset)\(openingTag)properties\(reset)\(punctuation)&gt;\(reset)
                \(punctuation)&lt;\(reset)\(openingTag)type\(reset)\(punctuation)&gt;\(reset)\(key)Input\(reset)\(closingTag)&lt;/type&gt;\(reset)
                \(punctuation)&lt;\(reset)\(openingTag)inputType\(reset)\(punctuation)&gt;\(reset)\(key)List\(reset)\(closingTag)&lt;/inputType&gt;\(reset)
                \(comment)&lt;!-- Comment --&gt;\(reset)
                \(punctuation)&lt;\(reset)\(openingTag)isAllowed\(reset)\(punctuation)&gt;\(reset)\(key)true\(reset)\(closingTag)&lt;/isAllowed&gt;\(reset)
            \(closingTag)&lt;/properties&gt;\(reset)
            """

        let result = XMLEnhancedInjector(type: .html).inject(in: stubHTMLString)

        XCTAssertEqual(result, expectedResult)
    }
}
