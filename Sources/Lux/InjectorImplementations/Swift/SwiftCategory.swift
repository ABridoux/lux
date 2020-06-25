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

    public var terminalColor: String {
        switch self {
        case .keyword: return TerminalModifier(colorCode: 168).raw
        case .string: return TerminalModifier(colorCode: 166).raw
        case .type: return TerminalModifier(colorCode: 37).raw
        case .call: return TerminalModifier(colorCode: 79).raw
        case .number: return TerminalModifier(colorCode: 98).raw
        case .comment: return TerminalModifier(colorCode: 249).raw
        case .property: return TerminalModifier(colorCode: 108).raw
        case .dotAccess: return TerminalModifier(colorCode: 194).raw
        case .preprocessing: return TerminalModifier(colorCode: 208).raw
        case .custom: return TerminalModifier.resetColors.raw
        }
    }

    public var color: Color {
        return theme.tokenColors[self] ?? theme.plainTextColor
    }

    public init(from match: String) {
        self = .custom(match)
    }

}
