#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public extension XMLDelegate {
    static var dracula: XMLDelegate { XMLDraculaDelegate() }
}

final class XMLDraculaDelegate: XMLDelegate, DraculaThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: XMLCategory) -> Color {
        switch category {
        case .tag: return Color.dracula.function
        case .key: return Color.dracula.functionParameter
        case .comment: return Color.dracula.comment
        case .header: return Color.dracula.fileHeader
        }
    }
    #endif

    override func terminalModifier(for category: XMLCategory) -> TerminalModifier {
        switch category {
        case .key: return TerminalModifier.dracula.function
        case .tag: return TerminalModifier.dracula.functionParameter
        case .comment: return TerminalModifier.dracula.comment
        case .header: return TerminalModifier.dracula.fileHeader
        }
    }
}
