import XCTest
@testable import Lux

private let folder = "Zsh"

final class ZshInjectorTests: XCTestCase {

    override func setUp() {
        // allows to access the test files in test functions
        // Otherwise the system interupts the read command with a Cocoa error 256
        _ = inputTestFile(with: .zsh, in: folder, order: 1, type: .plain)
    }

    func testFile1_Plain() {
        testFile(1, with: .terminal)
    }

    func testFile1_Html() {
        testFile(1, with: .html)
    }

    func testFile2_Plain() {
        testFile(2, with: .terminal)
    }

    func testFile2_Html() {
        testFile(2, with: .html)
    }

    func testFile3_Plain() {
        testFile(3, with: .terminal)
    }

    func testFile3_Html() {
        testFile(3, with: .html)
    }

    func testFile<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>(_ order: Int, with type: InjType, file: StaticString = #file, line: UInt = #line) {
        let input = inputTestFile(with: .zsh, in: folder, order: order, type: type.textType)
        let expectedOutput = outputTestFile(with: .zsh, in: folder, order: order, type: type.textType)

        // we use a delegate to ensure the colors and css classes used for the tests
        guard let output = ZshInjector(type: type, delegate: ZshTestDelegate()).inject(in: input) as? String else {
            fatalError("The output with Terminal or HTML should be a String")
        }

        guard output != expectedOutput else { return }

        let resultLines = output.split(separator: "\n")
        let expectedLines = expectedOutput.split(separator: "\n")

        let resultLinesCount = resultLines.count
        let expectedLinesCount = expectedLines.count

        guard resultLinesCount == expectedLinesCount else {
            XCTFail("Lines count not maching in output (\(resultLinesCount) lines) and expected output (\(expectedLinesCount) lines)", file: file, line: line)
            return
        }

        var index = 1
        for (resultLine, expectedLine) in zip(resultLines, expectedLines) {
            if resultLine != expectedLine {
                XCTFail("The lines \(index) are different.\nExpected: \(expectedLine)\nGot: \(resultLine)", file: file, line: line)
            }
            index += 1
        }
    }
}
