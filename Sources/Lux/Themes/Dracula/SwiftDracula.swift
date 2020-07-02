#if os(iOS)
import UIKit
#else
import AppKit
#endif

public extension SwiftDelegate {
    static var dracula: SwiftDelegate { SwiftDraculaDelegate() }
}

final class SwiftDraculaDelegate: SwiftDelegate, DraculaThemeInjectorDelegate {

    override func color(for category: SwiftCategory) -> Color {
        switch category {
        case .plainText: return Color.dracula.plainText
        case .call: return Color.dracula.function
        case .dotAccess: return Color.dracula.functionParameter
        case .keyword: return Color.dracula.keyword
        case .comment: return Color.dracula.comment
        case .number: return Color.dracula.constant
        case .preprocessing: return Color.dracula.fileHeader
        case .property: return Color.dracula.functionParameter
        case .custom: return Color.dracula.function
        case .string: return Color.dracula.string
        case .type: return Color.dracula.classOrType
        }
    }

    override func terminalModifier(for category: SwiftCategory) -> TerminalModifier {
        switch category {
        case .plainText: return TerminalModifier.dracula.plainText
        case .call: return TerminalModifier.dracula.function
        case .dotAccess: return TerminalModifier.dracula.functionParameter
        case .keyword: return TerminalModifier.dracula.keyword
        case .comment: return TerminalModifier.dracula.comment
        case .number: return TerminalModifier.dracula.constant
        case .preprocessing: return TerminalModifier.dracula.fileHeader
        case .property: return TerminalModifier.dracula.functionParameter
        case .custom: return TerminalModifier.dracula.function
        case .string: return TerminalModifier.dracula.string
        case .type: return TerminalModifier.dracula.classOrType
        }
    }
}
