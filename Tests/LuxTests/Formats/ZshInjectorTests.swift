import XCTest
@testable import Lux

private let folder = "Zsh"

final class ZshInjectorTests: XCTestCase {

    override func setUp() {
        // allows to access the test files in test functions
        // Otherwise the system interupts the read command with a Cocoa error 256
        _ = inputTestFile(with: .zsh, in: folder, order: 1, type: .plain)
    }

    func testFile1_Html() {
        test(1, th: .zsh, fileIn: folder, folderWith: .html)
    }

    func testFile2_Html() {
        test(1, th: .zsh, fileIn: folder, folderWith: .html)
    }

    func testFile3_Html() {
        test(1, th: .zsh, fileIn: folder, folderWith: .html)
    }

    func testFile4_Html() {
        test(1, th: .zsh, fileIn: folder, folderWith: .html)
    }
}
