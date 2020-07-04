#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLDelegate {
    static var xcodeLight: XMLDelegate { XMLXcodeLightDelegate() }
}

final class XMLXcodeLightDelegate: XMLDelegate, XcodeLightThemeInjectorDelegate {

    override func color(for category: XMLCategory) -> Color {
        switch category {
        case .tag: return Color.xcodeLight.property
        case .key: return Color.xcodeLight.plainText
        case .comment: return Color.xcodeLight.string
        case .header: return Color.xcodeLight.comment
        }
    }

    override func terminalModifier(for category: XMLCategory) -> TerminalModifier {
        switch category {
        case .tag: return TerminalModifier.xcodeLight.property
        case .key: return TerminalModifier.xcodeLight.plainText
        case .comment: return TerminalModifier.xcodeLight.string
        case .header: return TerminalModifier.xcodeLight.comment
        }
    }
}
