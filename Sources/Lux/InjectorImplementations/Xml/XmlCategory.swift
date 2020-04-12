import Foundation

/// Categories when dealing with Plist format: tag, key.
public enum XmlCategory: Category {

    // MARK: - Constants

    /// A Xml tag between brackets like `<tag>`
    case tag(Substring)
    /// A Xml key between tags like `<tag>key</tag>`
    case key(Substring)

    static let tagDefault = XmlCategory.tag("")
    static let keyDefault = XmlCategory.key("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .tag: return "xml-tag"
        case .key: return "xml-key"
        }
    }

    public var terminalColor: String {
        switch self {
        case .tag: return "\033[38;5;8m"
        case .key: return "\033[39m" // standard color
        }
    }

    // MARK: - Initialisation

    init(from match: Substring) {
        if match.hasPrefix("<") && match.hasSuffix(">") {
            var tag = match
            tag.removeFirst()
            tag.removeLast()
            self = .tag(tag)
        } else if match.hasPrefix("&lt;") && match.hasSuffix("&gt;") {
            var tag = match
            tag.removeFirst(4)
            tag.removeLast(4)
            self = .tag(tag)
        } else {
            self = .key(match)
        }
    }
}
