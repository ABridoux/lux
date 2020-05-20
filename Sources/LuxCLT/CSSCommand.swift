import Foundation
import ArgumentParser
import Lux

struct CSSCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "css", abstract: "Inject Css classes in a HTML file <pre><code> blocks")

    @Option(name: [.short, .customLong("input")], help: "A path to a file to read to inject Css classes in it")
    var inputFilePath: String

    @Option(name: [.short, .long])
    var format: Format

    func run() throws {
        // get the input
        let input = try String(contentsOf: URL(fileURLWithPath: inputFilePath.replacingTilde))

        // get the output
        let result: String

        switch format {
        case .xml: result = try FileInjectionService.injectXml(in: input)
        case .plist: result = try FileInjectionService.injectPlist(in: input)
        case .json: result = try FileInjectionService.injectJson(in: input)
        }

        try result.write(toFile: inputFilePath, atomically: true, encoding: .utf8)
    }
}
