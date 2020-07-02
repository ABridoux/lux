import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public enum XMLEnhancedCategory: Category {

    // MARK: - Constants

    /// A Xml opening tag between brackets like `<tag>`
    case openingTag(String)
    /// A Xml closing tag between brackets like `</tag>`
    case closingTag(String)

    /// Xml bracket
    case punctuation

    /// A Xml key between tags like `<tag>key</tag>`
    case key(String)
    /// A Xml  comment `<!-- Comment -->`
    case comment
    /// A Xml  header `<? ?>`
    case header

    static let openingTagDefault = Self.openingTag("")
    static let closingTagDefault = Self.closingTag("")
    static let keyDefault = Self.key("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .openingTag: return "xml-opening-tag"
        case .closingTag: return "xml-closing-tag"
        case .punctuation: return "xml-punctuation"
        case .key: return "xml-key"
        case .header: return "xml-header"
        case .comment: return "xml-comment"
        }
    }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .closingTag, .punctuation: return TerminalModifier(colorCode: 240)
        case .openingTag: return TerminalModifier(colorCode: 166)
        case .key: return .resetColors
        case .header: return TerminalModifier(colorCode: 247)
        case .comment: return TerminalModifier(colorCode: 67)
        }
    }

    // MARK: - Initialisation

    public init(from match: String) {
        let xmlCategory = XMLCategory(from: match)

        switch xmlCategory {
        case .comment: self = .comment
        case .header: self = .header
        case .key(let key): self = .key(key)
        case .tag(let tag):
            if tag.hasPrefix("/") {
                var tagWithoutSlash = tag
                tagWithoutSlash.removeFirst()
                self = .closingTag(tagWithoutSlash)
            } else {
                self = .openingTag(tag)
            }
        }
    }

    public var color: Color {
        switch self {
        case .closingTag, .punctuation: return .darkGray
        case .openingTag: return .orange
        case .key: return .black
        case .header: return .lightGray
        case .comment: return Color(r: 100, g: 193, b: 82)
        }
    }
}
