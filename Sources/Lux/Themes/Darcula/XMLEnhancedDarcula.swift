#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public extension XMLEnhancedDelegate {
    static var dracula: XMLEnhancedDelegate { XMLEnhancedDraculaDelegate() }
}

open class XMLEnhancedDraculaDelegate: XMLEnhancedDelegate {

    override open var backgroundColor: Color { Color(hex: "#282A36")! }

    override open func color(for category: XMLEnhancedCategory) -> Color {
        switch category {
        case .openingTag: return Color.dracula.function
        case .closingTag, .punctuation: return Color.dracula.punctuation
        case .key: return Color.dracula.functionParameter
        case .comment: return Color.dracula.comment
        case .header: return Color.dracula.fileHeader
        }
    }

    override open func terminalModifier(for category: XMLEnhancedCategory) -> TerminalModifier {
        switch category {
        case .key: return TerminalModifier.dracula.functionParameter
        case .openingTag: return TerminalModifier.dracula.functionParameter
        case .closingTag, .punctuation: return TerminalModifier.dracula.punctuation
        case .comment: return TerminalModifier.dracula.comment
        case .header: return TerminalModifier.dracula.fileHeader
        }
    }
}
