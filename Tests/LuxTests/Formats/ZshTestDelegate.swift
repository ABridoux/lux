import XCTest
import Lux

class ZshTestDelegate: ZshDelegate {

    override func cssClass(for category: ZshCategory) -> String {
        switch category {
        case .program: return "zsh-program"
        case .optionNameOrFlag: return "zsh-option-flag"
        case .commandOrOptionValue: return "zsh-command-option-value"
        case .punctuation: return "zsh-punctuation"
        case .variable: return "zsh-variable"
        case .keyword: return "zsh-keyword"
        case .string: return "zsh-string"
        case .comment: return "zsh-comment"
        }
    }

    override func terminalModifier(for category: ZshCategory) -> TerminalModifier {
        switch category {
        case .program: return .resetColors
        case .optionNameOrFlag: return TerminalModifier(colorCode: 106)
        case .commandOrOptionValue: return TerminalModifier(colorCode: 108)
        case .punctuation: return TerminalModifier(colorCode: 240)
        case .variable: return TerminalModifier(colorCode: 167)
        case .keyword: return TerminalModifier(colorCode: 24)
        case .string: return TerminalModifier(colorCode: 109)
        case .comment: return TerminalModifier(colorCode: 245)
        }
    }
}
