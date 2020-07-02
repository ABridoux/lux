#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension ZshDelegate {
    static var xcodeLight: ZshDelegate { ZshXcodeLightDelegate() }
}

final class ZshXcodeLightDelegate: ZshDelegate, XcodeDefaultThemeInjectorDelegate {

    override func color(for category: ZshCategory) -> Color {
        switch category {
        case .program: return Color.xcodeLight.call
        case .optionNameOrFlag: return Color.xcodeLight.dotAccess
        case .commandOrOptionValue: return Color.xcodeLight.number
        case .punctuation: return Color.xcodeLight.plainText
        case .variable: return Color.xcodeLight.property
        case .string: return Color.xcodeLight.string
        case .keyword: return Color.xcodeLight.keyword
        case .comment: return Color.xcodeLight.comment
        }
    }

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
