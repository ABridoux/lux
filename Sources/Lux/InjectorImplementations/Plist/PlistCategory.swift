import Foundation

/// Categories when dealing with Plist format: tag, key name and key value
public enum PlistCategory: Category {

    // MARK: - Constants

    /// A Plist tag between angles like `<key>` or `</dict>`
    case tag(Substring)
    /// A Plist key name between key tags like `<key>keyName</key>`
    case keyName(Substring)
    /// A Plist key value between value tags like `<string>Hello</string>` or `<real>2.5</real>`
    case keyValue(Substring)

    static let tagDefault = PlistCategory.tag("")
    static let keyNameDefault = PlistCategory.keyName("")
    static let keyValueDefault = PlistCategory.keyValue("")

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .tag: return "plist-tag"
        case .keyName: return "plist-key-name"
        case .keyValue: return "plist-key-value"
        }
    }

    public var terminalColor: String {
        switch self {
        case .tag: return "\033[38;5;8m"
        case .keyName: return "\033[38;5;161m"
        case .keyValue: return "\033[39m" // standard color
        }
    }
}
