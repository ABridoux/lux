#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

import Foundation

/// Categories for matches in a Plist format
public enum XMLCategory: Category {

    // MARK: - Constants

    /// A Xml tag between brackets like `<tag>`
    case tag(String)
    /// A Xml key between tags like `<tag>key</tag>`
    case key(String)
    /// A Xml  comment `<!-- Comment -->`
    case comment
    /// A Xml  header `<? ?>`
    case header

    static let tagDefault = XMLCategory.tag("")
    static let keyDefault = XMLCategory.key("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .tag: return "xml-tag"
        case .key: return "xml-key"
        case .header: return "xml-header"
        case .comment: return "xml-comment"
        }
    }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .tag: return TerminalModifier(colorCode: 243)
        case .key: return .resetColors // standard color
        case .header: return TerminalModifier(colorCode: 239)
        case .comment: return TerminalModifier(colorCode: 67)
        }
    }

    // MARK: - Initialisation

    public init(from match: String) {
        switch match {

        case \.isComment:
            self = .comment

        case \.isHeader:
            self = .header

        case \.isPlainTag:
            var tag = match
            tag.removeFirst()
            tag.removeLast()
            self = .tag(tag)

        case \.isHtmlTag:
            var tag = match
            tag.removeFirst(4)
            tag.removeLast(4)
            self = .tag(tag)

        default:
            self = .key(match)
        }
    }

    #if !os(Linux)
    public var color: Color {
        switch self {
        case .tag: return .red
        case .key: return .black
        case .header: return .lightGray
        case .comment: return Color(r: 100, g: 193, b: 82)
        }
    }
    #endif
}

private extension String {

    var isPlainTag: Bool { self.hasPrefix("<") && self.hasSuffix(">") }
    var isHtmlTag: Bool { self.hasPrefix("&lt;") && self.hasSuffix("&gt;") }
    var isHeader: Bool {
        hasPrefix("<?") && hasSuffix("?>")
        || hasPrefix("<!") && hasSuffix(">")
        || hasPrefix("&lt;?") && hasSuffix("?&gt;")
        || hasPrefix("&lt;!") && hasSuffix("&gt;")
    }
    var isComment: Bool {
        hasPrefix("<!--") && hasSuffix("-->")
        || hasPrefix("&lt;!--") && hasSuffix("--&gt;")
    }
}
