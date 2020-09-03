#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension JSONDelegate {
    static var xcodeDark: JSONDelegate { JSONXcodeDarkDelegate() }
}

final class JSONXcodeDarkDelegate: JSONDelegate, XcodeDarkThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: JSONCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeDark.property
        case .keyValue: return Color.xcodeDark.plainText
        case .punctuation: return Color.xcodeDark.comment
        }
    }
    #endif

    override func terminalModifier(for category: JSONCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeDark.property
        case .keyValue: return TerminalModifier.xcodeDark.plainText
        case .punctuation: return TerminalModifier.xcodeDark.comment
        }
    }
}
