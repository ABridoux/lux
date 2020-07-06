#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension PlistDelegate {
    static var xcodeDark: PlistDelegate { PlistXcodeDarkDelegate() }
}

final class PlistXcodeDarkDelegate: PlistDelegate, XcodeDarkThemeInjectorDelegate {

    override func color(for category: PlistCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeDark.property
        case .tag: return Color.xcodeDark.comment
        case .keyValue: return Color.xcodeDark.plainText
        case .comment: return Color.xcodeDark.string
        case .header: return Color.xcodeDark.comment
        }
    }

    override func terminalModifier(for category: PlistCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeDark.property
        case .tag: return TerminalModifier.xcodeDark.comment
        case .keyValue: return TerminalModifier.xcodeDark.plainText
        case .comment: return TerminalModifier.xcodeDark.string
        case .header: return TerminalModifier.xcodeDark.comment
        }
    }
}
