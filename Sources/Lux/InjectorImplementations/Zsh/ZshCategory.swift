import Foundation
#if !os(macOS)
import UIKit
#else
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

    public var terminalColor: String {
        switch self {
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

    public var color: Color {
        #if !os(macOS)
        switch self {
        case .program: return UIColor.black
        case .optionNameOrFlag: return UIColor(hex: "#F2836B")!
        case .commandOrOptionValue: return UIColor(hex: "#F2594B")!
        case .punctuation: return UIColor.systemGray
        case .variable: return UIColor(hex: "#63A69F")!
        case .string: return UIColor(hex: "#869CA6")!
        case .keyword: return UIColor(hex: "#A67574")!
        case .comment: return UIColor.lightGray
        }
        #else

        switch self {
        case .program: return NSColor.labelColor
        case .optionNameOrFlag: return NSColor(hex: "#F2836B")!
        case .commandOrOptionValue: return NSColor(hex: "#F2594B")!
        case .punctuation: return NSColor.systemGray
        case .variable: return NSColor(hex: "#63A69F")!
        case .string: return NSColor(hex: "#869CA6")!
        case .keyword: return NSColor(hex: "#A67574")!
        case .comment: return NSColor.lightGray
        }
        #endif
    }

    public init(from match: String) {
        switch match {
            // the order matters as some categories embrace others
        case \.isOptionNameOrFlag: self = .optionNameOrFlag
        case \.isPunctuation: self = .punctuation
        case \.isKeyword: self = .keyword
        case \.isVariable: self = .variable
        case \.isString: self = .string
        case \.isComment: self = .comment
        case \.isCommandOrOptionValue: self = .commandOrOptionValue
        default: self = .program
        }
    }
}

private extension String {

    static let punctuationSet: Set<String> =  ["[", "]", "(", ")", ";", "`", "{", "}"]
    static let keywordsSet: Set<String> = ["if", "fi", "elif", "do", "done", "then", "else", "for", "foreach",
                                           "while", "until", "repeat", "case", "select", "function", "time",
                                           "&", "&amp", "&&", "&amp&amp", "|", "||",
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
            || trimmed.hasPrefix("${") && trimmed.hasSuffix("}")
            || trimmed.hasPrefix("$") && !trimmed.hasPrefix("$(")
    }

    var isKeyword: Bool { Self.keywordsSet.contains(self.trimmingCharacters(in: .whitespacesAndNewlines)) }

    var isString: Bool { hasPrefix("\"") && hasSuffix("\"") || hasPrefix("'") && hasSuffix("'") }

    var isComment: Bool { hasPrefix("#") }
}
