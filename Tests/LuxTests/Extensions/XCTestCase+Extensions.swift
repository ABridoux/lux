import Foundation
import XCTest
import Lux

extension XCTestCase {

    func inputTestFile(with format: DataFormat, in folder: String, order: Int, type: TextType) -> String {
        let inputFileWithTypeURL = URL.testInputFileURL(with: format, in: folder, order: order, type: type)
        let inputFileURL = URL.testInputFileURL(with: format, in: folder, order: order)

        var string: String

        if FileManager.default.fileExists(atPath: inputFileWithTypeURL.path) {
            string = try! String(contentsOf: inputFileWithTypeURL)
        } else if FileManager.default.fileExists(atPath: inputFileURL.path) {
            string = try! String(contentsOf: inputFileURL)
        } else {
            assertionFailure("Unable to retrieve the input test file at \(inputFileWithTypeURL.path) or \(inputFileURL.path)")
            return ""
        }

        if type == .html {
            string = string.escapingHTMLEntities()
        }

        return string
    }

    func outputTestFile(with format: DataFormat, in folder: String, order: Int, type: TextType) -> String {
        let outputFileWithTypeURL = URL.testOutputFileURL(with: format, in: folder, order: order, type: type)

        guard FileManager.default.fileExists(atPath: outputFileWithTypeURL.path) else {
            assertionFailure("Unable to retrieve the input test file at \(outputFileWithTypeURL.path)")
            return ""
        }

        return try! String(contentsOf: outputFileWithTypeURL)
    }

    /// Test a plain input file in the TestDataFiles folder, with its injector type version: Html or Terminal
    /// - Parameters:
    ///   - order: The file number
    ///   - format: Language to test
    ///   - folder: Folder inside TestDataFiles where the file is located
    ///   - type: Html or Terminal
    func test<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>(_ order: Int, th format: DataFormat, fileIn folder: String, folderWith type: InjType, file: StaticString = #file, line: UInt = #line) {
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
