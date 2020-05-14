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

    static let tagDefault = XMLCategory.tag("")
    static let keyDefault = XMLCategory.key("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .tag: return "xml-tag"
        case .key: return "xml-key"
        }
    }

    public var terminalColor: String {
        switch self {
        case .tag: return "\u{001B}[38;5;197m"
        case .key: return "\u{001B}[0;0m" // standard color
        }
    }

    // MARK: - Initialisation

    public init(from match: String) {
        switch match {
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
        }

        #else

        switch self {
        case .tag: return NSColor.systemOrange
        case .key: return NSColor.labelColor
        }
        #endif
    }
}

private extension String {

    var isPlainTag: Bool { self.hasPrefix("<") && self.hasSuffix(">") }
    var isHtmlTag: Bool { self.hasPrefix("&lt;") && self.hasSuffix("&gt;") }
}
