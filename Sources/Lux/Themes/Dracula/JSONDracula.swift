#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension JSONDelegate {
    static var dracula: JSONDelegate { JSONDraculaDelegate() }
}

final class JSONDraculaDelegate: JSONDelegate, DraculaThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: JSONCategory) -> Color {
        switch category {
        case .keyName: return Color.dracula.function
        case .keyValue: return Color.dracula.functionParameter
        case .punctuation: return Color.dracula.punctuation
        }
    }
    #endif

    override func terminalModifier(for category: JSONCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.dracula.function
        case .keyValue: return TerminalModifier.dracula.functionParameter
        case .punctuation: return TerminalModifier.dracula.punctuation
        }
    }
}
