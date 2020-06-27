#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public extension PlistDelegate {
    static var dracula: PlistDelegate { PlistDraculaDelegate() }
}

open class PlistDraculaDelegate: PlistDelegate {

    override open var backgroundColor: Color { Color(hex: "#282A36")! }

    override open func color(for category: PlistCategory) -> Color {
        switch category {
        case .keyName: return Color.dracula.function
        case .tag: return Color.dracula.punctuation
        case .keyValue: return Color.dracula.functionParameter
        case .comment: return Color.dracula.comment
        case .header: return Color.dracula.fileHeader
        }
    }

    override open func terminalModifier(for category: PlistCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.dracula.function
        case .keyValue: return TerminalModifier.dracula.functionParameter
        case .tag: return TerminalModifier.dracula.punctuation
        case .comment: return TerminalModifier.dracula.comment
        case .header: return TerminalModifier.dracula.fileHeader
        }
    }
}
