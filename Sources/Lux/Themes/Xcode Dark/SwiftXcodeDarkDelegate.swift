#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension SwiftDelegate {
    static var xcodeDark: SwiftDelegate { SwiftXcodeDarkDelegate() }
}

final class SwiftXcodeDarkDelegate: SwiftDelegate, XcodeDarkThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: SwiftCategory) -> Color {
        switch category {
        case .plainText: return Color.xcodeDark.plainText
        case .call: return Color.xcodeDark.call
        case .dotAccess: return Color.xcodeDark.dotAccess
        case .keyword: return Color.xcodeDark.keyword
        case .comment: return Color.xcodeDark.comment
        case .number: return Color.xcodeDark.number
        case .preprocessing: return Color.xcodeDark.preprocessing
        case .property: return Color.xcodeDark.property
        case .custom: return Color.xcodeDark.custom
        case .string: return Color.xcodeDark.string
        case .type: return Color.xcodeDark.type
        }
    }
    #endif

    override func terminalModifier(for category: SwiftCategory) -> TerminalModifier {
        switch category {
        case .plainText: return TerminalModifier.xcodeDark.plainText
        case .call: return TerminalModifier.xcodeDark.call
        case .dotAccess: return TerminalModifier.xcodeDark.dotAccess
        case .keyword: return TerminalModifier.xcodeDark.keyword
        case .comment: return TerminalModifier.xcodeDark.comment
        case .number: return TerminalModifier.xcodeDark.number
        case .preprocessing: return TerminalModifier.xcodeDark.preprocessing
        case .property: return TerminalModifier.xcodeDark.property
        case .custom: return TerminalModifier.xcodeDark.custom
        case .string: return TerminalModifier.xcodeDark.string
        case .type: return TerminalModifier.xcodeDark.type
        }
    }
}
