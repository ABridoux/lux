import Foundation
import Splash
#if os(iOS)
import UIKit
#else
import AppKit
#endif

public enum SwiftCategory: Hashable {

    case plainText

    /// A keyword, such as `if`, `class`, `let` or attributes such as @available
    case keyword
    /// A token that is part of a string literal
    case string
    /// A reference to a type
    case type
    /// A call to a function or method
    case call
    /// A number, either interger of floating point
    case number
    /// A comment, either single or multi-line
    case comment
    /// A property being accessed, such as `object.property`
    case property
    /// A symbol being accessed through dot notation, such as `.myCase`
    case dotAccess
    /// A preprocessing symbol, such as `#if`
    case preprocessing
    /// A custom token type, containing an arbitrary string
    case custom(String)
}

extension SwiftCategory: Category {

    /// Return a string value representing the token type
    var string: String {
        if case .custom(let type) = self {
            return type
        }

        return "\(self)"
    }

    public var cssClass: String { "swift-\(string)" }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .plainText: return TerminalModifier.resetColors
        case .keyword: return TerminalModifier(colorCode: 90)
        case .string: return TerminalModifier(colorCode: 160)
        case .type: return TerminalModifier(colorCode: 23)
        case .call: return TerminalModifier(colorCode: 24)
        case .number: return TerminalModifier(colorCode: 21)
        case .comment: return TerminalModifier(colorCode: 245)
        case .property: return TerminalModifier(colorCode: 24)
        case .dotAccess: return TerminalModifier(colorCode: 24)
        case .preprocessing: return TerminalModifier(colorCode: 95)
        case .custom: return TerminalModifier.resetColors
        }
    }

    public var color: Color {
        switch self {
        case .plainText: return .black
        case .keyword: return Color(r: 155, g: 35, b: 147)
        case .string: return Color(r: 196, g: 26, b: 22)
        case .type: return Color(r: 28, g: 70, b: 74)
        case .call: return Color(r: 50, g: 109, b: 116)
        case .number: return Color(r: 28, g: 0, b: 7)
        case .comment: return Color(r: 93, g: 108, b: 121)
        case .property: return Color(r: 50, g: 109, b: 116)
        case .dotAccess: return Color(r: 50, g: 109, b: 116)
        case .preprocessing: return Color(r: 100, g: 56, b: 32)
        case .custom: return .black
        }
    }

    public init(from match: String) {
        self = .custom(match)
    }
}
