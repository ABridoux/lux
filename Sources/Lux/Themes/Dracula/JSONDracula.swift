#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public extension JSONDelegate {
    static var dracula: JSONDelegate { JSONDraculaDelegate() }
}

open class JSONDraculaDelegate: JSONDelegate {

    override open func color(for category: JSONCategory) -> Color {
        switch category {
        case .keyName: return Color.dracula.function
        case .keyValue: return Color.dracula.functionParameter
        case .punctuation: return Color.dracula.punctuation
        }
    }

    override open func terminalModifier(for category: JSONCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.dracula.function
        case .keyValue: return TerminalModifier.dracula.functionParameter
        case .punctuation: return TerminalModifier.dracula.punctuation
        }
    }
}
