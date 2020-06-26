import Foundation
import XCTest
import Lux

extension XCTestCase {

    func inputTestFile(with format: DataFormat, in folder: String, order: Int, type: TextType) -> String {
        let inputFileWithTypeURL = URL.testInputFileURL(with: format, in: folder, order: order, type: type)
        let inputFileURL = URL.testInputFileURL(with: format, in: folder, order: order)

        let string: String

        if FileManager.default.fileExists(atPath: inputFileWithTypeURL.path) {
            string = try! String(contentsOf: inputFileWithTypeURL)
        } else if FileManager.default.fileExists(atPath: inputFileURL.path) {
            string = try! String(contentsOf: inputFileURL)
        } else {
            assertionFailure("Unable to retrieve the input test file at \(inputFileWithTypeURL.path) or \(inputFileURL.path)")
            return ""
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
}
