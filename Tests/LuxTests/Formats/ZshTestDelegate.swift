import XCTest
import Lux

class ZshTestDelegate: ZshDelegate {

    override func injection(for category: ZshCategory, type: TextType) -> String {
        switch type {
        case .plain: return terminalColor(for: category)
        case .html: return cssClass(for: category)
        }
    }

    func cssClass(for category: ZshCategory) -> String {
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

    func terminalColor(for category: ZshCategory) -> String {
        switch category {
        case .program: return "\u{001B}[0;0m"
        case .optionNameOrFlag: return "\u{001B}[38;5;106m"
        case .commandOrOptionValue: return "\u{001B}[38;5;108m"
        case .punctuation: return "\u{001B}[38;5;240m"
        case .variable: return "\u{001B}[38;5;167m"
        case .keyword: return "\u{001B}[38;5;24m"
        case .string: return "\u{001B}[38;5;109m"
        case .comment: return "\u{001B}[38;5;245m"
        }
    }
}
