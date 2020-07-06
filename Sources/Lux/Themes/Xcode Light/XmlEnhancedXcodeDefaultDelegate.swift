#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLEnhancedDelegate {
    static var xcodeLight: XMLEnhancedDelegate { XMLEnhancedXcodeLightDelegate() }
}

final class XMLEnhancedXcodeLightDelegate: XMLEnhancedDelegate, XcodeLightThemeInjectorDelegate {

    override func color(for category: XMLEnhancedCategory) -> Color {
        switch category {
        case .openingTag: return Color.xcodeLight.property
        case .closingTag, .punctuation: return Color.xcodeLight.comment
        case .key: return Color.xcodeLight.plainText
        case .comment: return Color.xcodeLight.string
        case .header: return Color.xcodeLight.comment
        }
    }

    override func terminalModifier(for category: XMLEnhancedCategory) -> TerminalModifier {
        switch category {
        case .openingTag: return TerminalModifier.xcodeLight.property
        case .closingTag, .punctuation: return TerminalModifier.xcodeLight.comment
        case .key: return TerminalModifier.xcodeLight.plainText
        case .comment: return TerminalModifier.xcodeLight.string
        case .header: return TerminalModifier.xcodeLight.comment
        }
    }
}
