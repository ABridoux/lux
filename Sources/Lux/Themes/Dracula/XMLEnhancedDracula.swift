#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLEnhancedDelegate {
    static var dracula: XMLEnhancedDelegate { XMLEnhancedDraculaDelegate() }
}

final class XMLEnhancedDraculaDelegate: XMLEnhancedDelegate, DraculaThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: XMLEnhancedCategory) -> Color {
        switch category {
        case .openingTag: return Color.dracula.function
        case .closingTag, .punctuation: return Color.dracula.punctuation
        case .key: return Color.dracula.functionParameter
        case .comment: return Color.dracula.comment
        case .header: return Color.dracula.fileHeader
        }
    }
    #endif

    override func terminalModifier(for category: XMLEnhancedCategory) -> TerminalModifier {
        switch category {
        case .key: return TerminalModifier.dracula.functionParameter
        case .openingTag: return TerminalModifier.dracula.functionParameter
        case .closingTag, .punctuation: return TerminalModifier.dracula.punctuation
        case .comment: return TerminalModifier.dracula.comment
        case .header: return TerminalModifier.dracula.fileHeader
        }
    }
}
