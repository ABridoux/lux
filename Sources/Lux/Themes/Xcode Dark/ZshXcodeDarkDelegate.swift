#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension ZshDelegate {
    static var xcodeDark: ZshDelegate { ZshXcodeDarkDelegate() }
}

final class ZshXcodeDarkDelegate: ZshDelegate, XcodeDarkThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: ZshCategory) -> Color {
        switch category {
        case .program: return Color.xcodeDark.call
        case .optionNameOrFlag: return Color.xcodeDark.plainText
        case .commandOrOptionValue: return Color.xcodeDark.number
        case .punctuation: return Color.xcodeDark.plainText
        case .variable: return Color.xcodeDark.type
        case .string: return Color.xcodeDark.string
        case .keyword: return Color.xcodeDark.keyword
        case .comment: return Color.xcodeDark.comment
        }
    }
    #endif

    override func terminalModifier(for category: ZshCategory) -> TerminalModifier {
        switch category {
        case .program: return TerminalModifier.xcodeDark.call
        case .optionNameOrFlag: return TerminalModifier.xcodeDark.plainText
        case .commandOrOptionValue: return TerminalModifier.xcodeDark.number
        case .punctuation: return TerminalModifier.xcodeDark.plainText
        case .variable: return TerminalModifier.xcodeDark.type
        case .string: return TerminalModifier.xcodeDark.string
        case .keyword: return TerminalModifier.xcodeDark.keyword
        case .comment: return TerminalModifier.xcodeDark.comment
        }
    }
}
