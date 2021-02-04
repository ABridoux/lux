#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// Categories for matches in a Plist format
public enum PlistCategory: Category {

    // MARK: - Constants

    /// A Plist tag between brackets like `<key>` or `</dict>`
    case tag(String)
    /// A Plist key name between key tags like `<key>keyName</key>`
    case keyName(String)
    /// A Plist key value between value tags like `<string>Hello</string>` or `<real>2.5</real>`
    case keyValue(String)
    /// A Plist  comment `<!-- Comment -->`
    case comment
    /// A Plist  header `<? ?>`
    case header

    static let tagDefault = PlistCategory.tag("")
    static let keyNameDefault = PlistCategory.keyName("")
    static let keyValueDefault = PlistCategory.keyValue("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .tag: return "plist-tag"
        case .keyName: return "plist-key-name"
        case .keyValue: return "plist-key-value"
        case .comment: return "plist-comment"
        case .header: return "plist-header"
        }
    }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .tag: return TerminalModifier(colorCode: 243)
        case .keyName: return TerminalModifier(colorCode: 166)
        case .keyValue: return .resetColors // standard color
        case .header: return TerminalModifier(colorCode: 239)
        case .comment: return TerminalModifier(colorCode: 67)
        }
    }

    #if !os(Linux)
    public var color: Color {
        switch self {
        case .tag: return .darkGray
        case .keyName: return .red
        case .keyValue: return .black
        case .header: return .lightGray
        case .comment: return Color(r: 100, g: 193, b: 82)
        }
    }
    #endif
    
    // MARK: - Initilisation

    public init(from match: String) {
        self = .tag(match)
        assertionFailure("The PlistCategory implements the Category protocol, but the injector will uses the XML category to determine the Plist one, with a previous match check")
    }
}
