import Foundation
import ArgumentParser
import Lux

struct CSSCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "css", abstract: "Inject Css classes in a HTML file <pre><code> blocks")

    @Option(name: [.short, .customLong("input")], help: "A path to a file to read to inject Css classes in it")
    var inputFilePath: String

    @Option(name: [.short, .long], parsing: .upToNextOption)
    var formats: [Format]

    func run() throws {
        // get the input
        let input = try String(contentsOf: URL(fileURLWithPath: inputFilePath.replacingTilde))

        // get the output
        let result = try FileInjectionService.inject(in: input, using: formats.map { $0.injector(type: .html) })

        try result.write(toFile: inputFilePath, atomically: true, encoding: .utf8)
    }
}
