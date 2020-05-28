import Foundation
#if !os(macOS)
import UIKit
#else
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

    public var terminalColor: String {
        switch self {
        case .closingTag, .punctuation: return "\u{001B}[38;5;240m"
        case .openingTag: return "\u{001B}[38;5;166m"
        case .key: return "\u{001B}[0;0m" // standard color
        case .header: return "\u{001B}[38;5;247m"
        case .comment: return "\u{001B}[38;5;67m"
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
        #if !os(macOS)
        switch self {
        case .closingTag, .punctuation: return UIColor.darkGray
        case .openingTag: return UIColor.orange
        case .key: return UIColor.black
        case .header: return UIColor.lightGray
        case .comment: return UIColor(red: 100 / 255, green: 193 / 255, blue: 82 / 255, alpha: 1)
        }

        #else

        switch self {
        case .closingTag, .punctuation: return NSColor.systemGray
        case .openingTag: return NSColor.systemOrange
        case .key: return NSColor.labelColor
        case .header: return NSColor.lightGray
        case .comment: return NSColor.systemGreen
        }
        #endif
    }
}
