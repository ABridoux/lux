import Foundation
import ArgumentParser
import Lux

struct LuxCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "lux",
                                                    subcommands: [InjectCommand.self, CssCommand.self],
                                                    defaultSubcommand: InjectCommand.self)
}

LuxCommand.main()
