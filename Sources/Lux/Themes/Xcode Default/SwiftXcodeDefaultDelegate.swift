#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension SwiftDelegate {
    static var xcodeLight: SwiftDelegate { SwiftXcodeLightDelegate() }
}

final class SwiftXcodeLightDelegate: SwiftDelegate, XcodeDefaultThemeInjectorDelegate {

    override func color(for category: SwiftCategory) -> Color {
        switch category {
        case .plainText: return Color.xcodeLight.plainText
        case .call: return Color.xcodeLight.call
        case .dotAccess: return Color.xcodeLight.dotAccess
        case .keyword: return Color.xcodeLight.keyword
        case .comment: return Color.xcodeLight.comment
        case .number: return Color.xcodeLight.number
        case .preprocessing: return Color.xcodeLight.preprocessing
        case .property: return Color.xcodeLight.property
        case .custom: return Color.xcodeLight.custom
        case .string: return Color.xcodeLight.string
        case .type: return Color.xcodeLight.type
        }
    }

    override func terminalModifier(for category: SwiftCategory) -> TerminalModifier {
        switch category {
        case .plainText: return TerminalModifier.xcodeLight.plainText
        case .call: return TerminalModifier.xcodeLight.call
        case .dotAccess: return TerminalModifier.xcodeLight.dotAccess
        case .keyword: return TerminalModifier.xcodeLight.keyword
        case .comment: return TerminalModifier.xcodeLight.comment
        case .number: return TerminalModifier.xcodeLight.number
        case .preprocessing: return TerminalModifier.xcodeLight.preprocessing
        case .property: return TerminalModifier.xcodeLight.property
        case .custom: return TerminalModifier.xcodeLight.custom
        case .string: return TerminalModifier.xcodeLight.string
        case .type: return TerminalModifier.xcodeLight.type
        }
    }
}
