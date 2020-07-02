#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension ZshDelegate {
    static var dracula: ZshDelegate { ZshDraculaDelegate() }
}

final class ZshDraculaDelegate: ZshDelegate, DraculaThemeInjectorDelegate {

    override func color(for category: ZshCategory) -> Color {
        switch category {
        case .program: return Color.dracula.function
        case .optionNameOrFlag: return Color.dracula.functionsDecorator
        case .commandOrOptionValue: return Color.dracula.functionParameter
        case .punctuation: return Color.dracula.punctuation
        case .variable: return Color.dracula.variable
        case .string: return Color.dracula.string
        case .keyword: return Color.dracula.keyword
        case .comment: return Color.dracula.comment
        }
    }

    override func terminalModifier(for category: ZshCategory) -> TerminalModifier {
        switch category {
        case .program: return TerminalModifier.dracula.function
        case .optionNameOrFlag: return TerminalModifier.dracula.functionDecorator
        case .commandOrOptionValue: return TerminalModifier.dracula.functionParameter
        case .punctuation: return TerminalModifier.dracula.punctuation
        case .variable: return TerminalModifier.dracula.variable
        case .string: return TerminalModifier.dracula.string
        case .keyword: return TerminalModifier.dracula.keyword
        case .comment: return TerminalModifier.dracula.comment
        }
    }
}
