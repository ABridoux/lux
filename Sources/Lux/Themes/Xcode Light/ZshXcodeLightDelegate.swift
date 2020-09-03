#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension ZshDelegate {
    static var xcodeLight: ZshDelegate { ZshXcodeLightDelegate() }
}

final class ZshXcodeLightDelegate: ZshDelegate, XcodeLightThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: ZshCategory) -> Color {
        switch category {
        case .program: return Color.xcodeLight.call
        case .optionNameOrFlag: return Color.xcodeLight.plainText
        case .commandOrOptionValue: return Color.xcodeLight.number
        case .punctuation: return Color.xcodeLight.plainText
        case .variable: return Color.xcodeLight.type
        case .string: return Color.xcodeLight.string
        case .keyword: return Color.xcodeLight.keyword
        case .comment: return Color.xcodeLight.comment
        }
    }
    #endif

    override func terminalModifier(for category: ZshCategory) -> TerminalModifier {
        switch category {
        case .program: return TerminalModifier.xcodeLight.call
        case .optionNameOrFlag: return TerminalModifier.xcodeLight.plainText
        case .commandOrOptionValue: return TerminalModifier.xcodeLight.number
        case .punctuation: return TerminalModifier.xcodeLight.plainText
        case .variable: return TerminalModifier.xcodeLight.type
        case .string: return TerminalModifier.xcodeLight.string
        case .keyword: return TerminalModifier.xcodeLight.keyword
        case .comment: return TerminalModifier.xcodeLight.comment
        }
    }
}
