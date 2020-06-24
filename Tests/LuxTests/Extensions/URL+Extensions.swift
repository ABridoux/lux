import Foundation
import Lux

extension URL {

    static let testFilesFolder: URL = {
        /**https://stackoverflow.com/questions/57555856/get-url-to-a-local-file-with-spm-swift-package-manager/57708634#57708634 */
        let currentFileURL = URL(fileURLWithPath: "\(#file)", isDirectory: false)
        return currentFileURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("TestDataFiles", isDirectory: true)
    }()

    static func testInputFileURL(with format: DataFormat, in folder: String, order: Int, type: TextType? = nil) -> URL {
        var fileName = "\(format.rawValue.capitalized)Input\(order)"

        if let type = type {
            fileName.append("_\(type.rawValue.capitalized)")
        }

        return testFilesFolder.appendingPathComponent(folder, isDirectory: true).appendingPathComponent(fileName, isDirectory: false)
    }

    static func testOutputFileURL(with format: DataFormat, in folder: String, order: Int, type: TextType) -> URL {
        let fileName = "\(format.rawValue.capitalized)Output\(order)_\(type.rawValue.capitalized)"

        return testFilesFolder.appendingPathComponent(folder, isDirectory: true).appendingPathComponent(fileName)
    }
}
