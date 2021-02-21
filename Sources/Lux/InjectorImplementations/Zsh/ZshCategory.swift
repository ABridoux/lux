import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public enum ZshCategory: Category {
    /// A program to execute
    case program

    /// An option name with hyphens or flags (e.g. `-c`, `--config`, `--verbose`)
    case optionNameOrFlag

    /// A program command (e.g. `launchctl unload`) or an option value (e.g. `-f plist `)
    case commandOrOptionValue

    /// Punctuation character like `{`, `[`, `;`...
    case punctuation

    /// A variable defined with a `=` sign, and used with an `$`sign
    case variable

    /// A language keyword
    case keyword

    /// A string quoted with single or double quotes
    case string

    /// Line starting with #
    case comment

    public var cssClass: String {
        switch self {
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

    public var terminalModifier: TerminalModifier {
        switch self {
        case .program: return .resetColors
        case .optionNameOrFlag: return TerminalModifier(colorCode: 29)
        case .commandOrOptionValue: return TerminalModifier(colorCode: 65)
        case .punctuation: return TerminalModifier(colorCode: 240)
        case .variable: return TerminalModifier(colorCode: 167)
        case .keyword: return TerminalModifier(colorCode: 24)
        case .string: return TerminalModifier(colorCode: 25)
        case .comment: return TerminalModifier(colorCode: 245)
        }
    }

    #if !os(Linux)
    public var color: Color {
        switch self {
        case .program: return .black
        case .optionNameOrFlag: return Color(r: 242, g: 131, b: 107, a: 95)
        case .commandOrOptionValue: return Color(r: 242, g: 89, b: 75)
        case .punctuation: return .systemGray
        case .variable: return Color(r: 99, g: 166, b: 159)
        case .string: return Color(r: 134, g: 156, b: 166)
        case .keyword: return Color(r: 166, g: 117, b: 116)
        case .comment: return .lightGray
        }
    }
    #endif

    public init(from match: String) {
        switch match {
            // the order matters as some categories embrace others
        case \.isOptionNameOrFlag: self = .optionNameOrFlag
        case \.isPunctuation: self = .punctuation
        case \.isKeyword: self = .keyword
        case \.isVariable: self = .variable
        case \.isString: self = .string
        case \.isComment: self = .comment
        case \.isProgram: self = .program
        case \.isCommandOrOptionValue: self = .commandOrOptionValue
        default: self = .program
        }
    }
}

private extension String {

    static let punctuationSet: Set<String> =  ["[", "]", "(", ")", ";", "`", "{", "}", "\\"]
    static let keywordsSet: Set<String> = ["if", "fi", "elif", "do", "done", "then", "else", "for", "foreach",
                                           "while", "until", "repeat", "case", "select", "function", "time",
                                           "&", "&amp;", "&&", "&amp;&amp;", "|", "||",
                                           ">", "&gt;", ">>", "&gt;&gt;", "<", "&lt;", "<<", "&lt;&lt;",
                                           "$", "=", "==", "!="]

    var isProgram: Bool {
        hasPrefix("$(") && count > 2 // we not capturing only whitespaces after $(
        || hasPrefix("sudo") && count > 4
        || hasPrefix("[") && count > 1
        || hasPrefix("`") && count > 1
        || hasPrefix("|") && count > 1
        || hasPrefix("\n") && count > 1
        || hasPrefix("\r") && count > 1
        || hasPrefix("./") && count > 2
        || hasPrefix("/") && count > 1
    }

    var isCommandOrOptionValue: Bool {
        let decimalAndHyphenCharacterSet = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "-"))

        return hasPrefix(" ")
            || hasPrefix("/")
            || hasPrefix(".")
            || hasPrefix("-") && trimmingCharacters(in: decimalAndHyphenCharacterSet).isEmpty
    }

    var isOptionNameOrFlag: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)

        let decimalAndHyphenCharacterSet = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "-"))
        return !trimmed.trimmingCharacters(in: decimalAndHyphenCharacterSet).isEmpty // do not categorise minus numbers as option or flag
        && (trimmed.hasPrefix("-") || trimmed.hasPrefix("--"))
    }

    var isPunctuation: Bool { Self.punctuationSet.contains(self) }

    var isVariable: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.hasSuffix("=")
            || trimmed.hasSuffix("=$")
            || trimmed.hasPrefix("${") && trimmed.hasSuffix("}")
            || trimmed.hasPrefix("$") && !trimmed.hasPrefix("$(")
    }

    var isKeyword: Bool { Self.keywordsSet.contains(self.trimmingCharacters(in: .whitespacesAndNewlines)) }

    var isString: Bool { hasPrefix("\"") && hasSuffix("\"") || hasPrefix("'") && hasSuffix("'") }

    var isComment: Bool { hasPrefix("#") }
}
