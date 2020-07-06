#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension JSONDelegate {
    static var xcodeLight: JSONDelegate { JSONXcodeLightDelegate() }
}

final class JSONXcodeLightDelegate: JSONDelegate, XcodeLightThemeInjectorDelegate {

    override func color(for category: JSONCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeLight.property
        case .keyValue: return Color.xcodeLight.plainText
        case .punctuation: return Color.xcodeLight.comment
        }
    }

    override func terminalModifier(for category: JSONCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeLight.property
        case .keyValue: return TerminalModifier.xcodeLight.plainText
        case .punctuation: return TerminalModifier.xcodeLight.comment
        }
    }
}
