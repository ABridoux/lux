import Foundation
import ArgumentParser
import Lux

struct InjectCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "inject", abstract: "Inject color marks in the input text")

    @Option(name: [.short, .customLong("input")], help: "A path to a file to read to inject the color marks")
    var inputFilePath: String?

    @Option(name: [.short, .long], help: "Specify HTML or plain text type. Default is plain")
    var type: TextType?

    @Option(name: [.short, .long], help: "plist, xml, json, yaml, swift, zsh")
    var format: Format

    @Option(name: [.long], help: "Choose a theme to use when outputting the data")
    var theme: ColorTheme?

    @Flag(name: [.long], inversion: .prefixedNo, help: "If true, the HTML special characters in the code blocks will be escaped when type is html")
    var escapeHTML = true

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
        let type = self.type ?? .plain
        let output: String

        switch type {
        case .plain:
            output = format.injector(injectorType: .terminal, theme: theme).inject(in: input)
        case .html:
            output = format.injector(injectorType: .html, theme: theme, escapingHTML: escapeHTML).inject(in: input)
        }

        print(output)
    }
}
