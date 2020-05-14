import Foundation
#if !os(macOS)
import UIKit
#else
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
        case .tag: return "\u{001B}[38;5;240m"
        case .keyName: return "\u{001B}[38;5;197m"
        case .keyValue: return "\u{001B}[0;0m" // standard color
        }
    }

    public var color: Color {
        #if !os(macOS)
        switch self {
        case .tag: return UIColor.lightGray
        case .keyName: return UIColor.red
        case .keyValue: return UIColor.black
        }

        #else

        switch self {
        case .tag: return NSColor.systemGray
        case .keyName: return NSColor.systemOrange
        case .keyValue: return NSColor.labelColor
        }
        #endif
    }

    // MARK: - Initilisation

    public init(from match: String) {
        self = .tag(match)
        assertionFailure("The PlistCategory implements the Category protocol, but the injector will uses the XML category to determine the Plist one, with a previous match check")
    }
}
