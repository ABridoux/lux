import XCTest
@testable import Lux

final class InjectorTests: XCTestCase {

    // MARK: - Constants

    let stubXmlString =
        """
        <properties>
            <type>Input</type>
            <inputType>List</inputType>
            <isAllowed>true</isAllowed>
        </properties>
        """

    // MARK: - Functions

    func testInjectorShouldInjectNA_Plain() throws {
        let result = try Injector.inject(in: stubXmlString, following: .plainXml) { match in
            if match.hasPrefix("<"), match.hasSuffix(">") {
                return "<NA>"
            } else {
                return String(match)
            }
        }

        let expectedResult =
            """
            <NA>
                <NA>Input<NA>
                <NA>List<NA>
                <NA>true<NA>
            <NA>
            """

        XCTAssertEqual(result, expectedResult)
    }
}
