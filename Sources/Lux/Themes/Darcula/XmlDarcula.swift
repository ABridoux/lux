#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public extension XMLDelegate {
    static var dracula: XMLDelegate { XMLDraculaDelegate() }
}

open class XMLDraculaDelegate: XMLDelegate {

    override open var backgroundColor: Color { Color(hex: "#282A36")! }

    override open func color(for category: XMLCategory) -> Color {
        switch category {
        case .tag: return Color.dracula.function
        case .key: return Color.dracula.functionParameter
        case .comment: return Color.dracula.comment
        case .header: return Color.dracula.fileHeader
        }
    }

    override open func terminalModifier(for category: XMLCategory) -> TerminalModifier {
        switch category {
        case .key: return TerminalModifier.dracula.function
        case .tag: return TerminalModifier.dracula.functionParameter
        case .comment: return TerminalModifier.dracula.comment
        case .header: return TerminalModifier.dracula.fileHeader
        }
    }
}
