import Foundation
import Splash
#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public typealias SwiftCategory = TokenType

extension TokenType: Category {

    var theme: Theme { .presentation(withFont: .init(size: 12)) }
    public var cssClass: String { "swift-\(string)" }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .keyword: return TerminalModifier(colorCode: 168)
        case .string: return TerminalModifier(colorCode: 166)
        case .type: return TerminalModifier(colorCode: 37)
        case .call: return TerminalModifier(colorCode: 79)
        case .number: return TerminalModifier(colorCode: 98)
        case .comment: return TerminalModifier(colorCode: 249)
        case .property: return TerminalModifier(colorCode: 108)
        case .dotAccess: return TerminalModifier(colorCode: 194)
        case .preprocessing: return TerminalModifier(colorCode: 208)
        case .custom: return TerminalModifier.resetColors
        }
    }

    public var color: Color {
        return theme.tokenColors[self] ?? theme.plainTextColor
    }

    public init(from match: String) {
        self = .custom(match)
    }

}
