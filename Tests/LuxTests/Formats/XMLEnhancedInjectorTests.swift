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
        let openingTag = XMLEnhancedCategory.openingTagDefault.terminalModifier.raw
        let closingTag = XMLEnhancedCategory.closingTagDefault.terminalModifier.raw
        let punctuation = XMLEnhancedCategory.punctuation.terminalModifier.raw
        let comment = XMLEnhancedCategory.comment.terminalModifier.raw
        let header = XMLEnhancedCategory.header.terminalModifier.raw
        let key = XMLEnhancedCategory.keyDefault.terminalModifier.raw
        let reset = Colors.terminalReset

        let expectedResult =
            """
            \(header)<?xml version="1.0" encoding="UTF-8"?>\(reset)
            \(punctuation)<\(reset)\(openingTag)properties\(reset)\(punctuation)>\(reset)
                \(punctuation)<\(reset)\(openingTag)type\(reset)\(punctuation)>\(reset)\(key)Input\(reset)\(punctuation)</\(reset)\(closingTag)type\(reset)\(punctuation)>\(reset)
                \(punctuation)<\(reset)\(openingTag)inputType\(reset)\(punctuation)>\(reset)\(key)List\(reset)\(punctuation)</\(reset)\(closingTag)inputType\(reset)\(punctuation)>\(reset)
                \(comment)<!-- Comment -->\(reset)
                \(punctuation)<\(reset)\(openingTag)isAllowed\(reset)\(punctuation)>\(reset)\(key)true\(reset)\(punctuation)</\(reset)\(closingTag)isAllowed\(reset)\(punctuation)>\(reset)
            \(punctuation)</\(reset)\(closingTag)properties\(reset)\(punctuation)>\(reset)
            """

        let result = XMLEnhancedInjector(type: .terminal).inject(in: stubXmlString)

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
                \(punctuation)&lt;\(reset)\(openingTag)type\(reset)\(punctuation)&gt;\(reset)\(key)Input\(reset)\(punctuation)&lt;/\(reset)\(closingTag)type\(reset)\(punctuation)&gt;\(reset)
                \(punctuation)&lt;\(reset)\(openingTag)inputType\(reset)\(punctuation)&gt;\(reset)\(key)List\(reset)\(punctuation)&lt;/\(reset)\(closingTag)inputType\(reset)\(punctuation)&gt;\(reset)
                \(comment)&lt;!-- Comment --&gt;\(reset)
                \(punctuation)&lt;\(reset)\(openingTag)isAllowed\(reset)\(punctuation)&gt;\(reset)\(key)true\(reset)\(punctuation)&lt;/\(reset)\(closingTag)isAllowed\(reset)\(punctuation)&gt;\(reset)
            \(punctuation)&lt;/\(reset)\(closingTag)properties\(reset)\(punctuation)&gt;\(reset)
            """

        let result = XMLEnhancedInjector(type: .html).inject(in: stubHTMLString)

        XCTAssertEqual(result, expectedResult)
    }
}
