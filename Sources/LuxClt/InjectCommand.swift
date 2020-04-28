import Foundation
import ArgumentParser
import Lux

struct InjectCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "inject", abstract: "Inject color markers in the input text")

    @Option(name: [.short, .customLong("input")], help: "A path to a file to read to inject the colorr markers")
    var inputFilePath: String?

    @Option(name: [.short, .long])
    var type: TextType

    @Option(name: [.short, .long])
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
        let output: String

        switch format {
        case .xml: output = XmlInjector(type: type).inject(in: input)
        case .plist: output = PlistInjector(type: type).inject(in: input)
        case .json: output = JSONInjector(type: type).inject(in: input)
        }

        print(output)
    }
}
