#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLDelegate {
    static var xcodeDark: XMLDelegate { XMLXcodeDarkDelegate() }
}

final class XMLXcodeDarkDelegate: XMLDelegate, XcodeDarkThemeInjectorDelegate {

    override func color(for category: XMLCategory) -> Color {
        switch category {
        case .tag: return Color.xcodeDark.property
        case .key: return Color.xcodeDark.plainText
        case .comment: return Color.xcodeDark.string
        case .header: return Color.xcodeDark.comment
        }
    }

    override func terminalModifier(for category: XMLCategory) -> TerminalModifier {
        switch category {
        case .tag: return TerminalModifier.xcodeDark.property
        case .key: return TerminalModifier.xcodeDark.plainText
        case .comment: return TerminalModifier.xcodeDark.string
        case .header: return TerminalModifier.xcodeDark.comment
        }
    }
}
