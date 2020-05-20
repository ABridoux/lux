import Foundation
import ArgumentParser
import Lux

struct InjectCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "inject", abstract: "Inject color marks in the input text")

    @Option(name: [.short, .customLong("input")], help: "A path to a file to read to inject the color marks")
    var inputFilePath: String?

    @Option(name: [.short, .long], help: "Specify HTML or plain text type. Default is plain")
    var type: TextType?

    @Option(name: [.short, .long], help: "plist, xml, json")
    var format: Format

    func run() throws {
        // get the input
        let data: Data

        if let filePath = inputFilePath {
            data = try Data(contentsOf: URL(fileURLWithPath: filePath.replacingTilde))
        } else {
            data = FileHandle.standardInput.readDataToEndOfFile()
        }
        guard let input = String(data: data, encoding: .utf8) else {
            throw RuntimeError.invalidData
        }

        // get the output
        let output = format.injector(type: type ?? .plain).inject(in: input)
        print(output)
    }
}
