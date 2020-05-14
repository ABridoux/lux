import Foundation
#if !os(macOS)
import UIKit
#else
import AppKit
#endif

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

    public var terminalColor: String {
        switch self {
        case .tag: return "\u{001B}[38;5;166m"
        case .key: return "\u{001B}[0;0m" // standard color
        case .header: return "\u{001B}[38;5;247m"
        case .comment: return "\u{001B}[38;5;67m"
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

    public var color: Color {
        #if !os(macOS)
        switch self {
        case .tag: return UIColor.red
        case .key: return UIColor.black
        case .header: return UIColor.lightGray
        case .comment: return UIColor.green
        }

        #else

        switch self {
        case .tag: return NSColor.systemOrange
        case .key: return NSColor.labelColor
        case .header: return NSColor.lightGray
        case .comment: return NSColor.systemGreen
        }
        #endif
    }
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
