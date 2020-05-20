import Foundation
import ArgumentParser
import Lux

struct LuxCommand: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "lux",
                                                    version: Version.current,
                                                    subcommands: [
                                                        InjectCommand.self,
                                                        CSSCommand.self,
                                                        VersionCommand.self],
                                                    defaultSubcommand: InjectCommand.self)
}

LuxCommand.main()
