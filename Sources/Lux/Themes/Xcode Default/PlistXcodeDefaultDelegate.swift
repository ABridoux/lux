#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension PlistDelegate {
    static var xcodeLight: PlistDelegate { PlistXcodeLightDelegate() }
}

final class PlistXcodeLightDelegate: PlistDelegate, XcodeDefaultThemeInjectorDelegate {

    override func color(for category: PlistCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeLight.property
        case .tag: return Color.xcodeLight.comment
        case .keyValue: return Color.xcodeLight.plainText
        case .comment: return Color.xcodeLight.string
        case .header: return Color.xcodeLight.comment
        }
    }

    override func terminalModifier(for category: PlistCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeLight.property
        case .tag: return TerminalModifier.xcodeLight.comment
        case .keyValue: return TerminalModifier.xcodeLight.plainText
        case .comment: return TerminalModifier.xcodeLight.string
        case .header: return TerminalModifier.xcodeLight.comment
        }
    }
}
