#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLEnhancedDelegate {
    static var xcodeDark: XMLEnhancedDelegate { XMLEnhancedXcodeDarkDelegate() }
}

final class XMLEnhancedXcodeDarkDelegate: XMLEnhancedDelegate, XcodeDarkThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: XMLEnhancedCategory) -> Color {
        switch category {
        case .openingTag: return Color.xcodeDark.property
        case .closingTag, .punctuation: return Color.xcodeDark.comment
        case .key: return Color.xcodeDark.plainText
        case .comment: return Color.xcodeDark.string
        case .header: return Color.xcodeDark.comment
        }
    }
    #endif

    override func terminalModifier(for category: XMLEnhancedCategory) -> TerminalModifier {
        switch category {
        case .openingTag: return TerminalModifier.xcodeDark.property
        case .closingTag, .punctuation: return TerminalModifier.xcodeDark.comment
        case .key: return TerminalModifier.xcodeDark.plainText
        case .comment: return TerminalModifier.xcodeDark.string
        case .header: return TerminalModifier.xcodeDark.comment
        }
    }
}
