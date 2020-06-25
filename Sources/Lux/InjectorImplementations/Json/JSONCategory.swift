import Foundation
#if !os(macOS)
import UIKit
#else
import AppKit
#endif

/// Categories for matches in a Json format
public enum JSONCategory: Category {

    // MARK: - Constants

    /// A Json key name when working with dictionaries
    case keyName
    /// A single value inside a dictionary or an array
    case keyValue
    /// A square or curl bracket, a coma, a double quote or two points
    case punctuation

    // MARK: - Properties

    public var cssClass: String {
        switch self {
        case .keyName: return "json-key-name"
        case .keyValue: return "json-key-value"
        case .punctuation: return "json-punctuation"
        }
    }

    public var terminalModifier: TerminalModifier {
        switch self {
        case .keyName: return TerminalModifier(colorCode: 166)
        case .keyValue: return .resetColors
        case .punctuation: return TerminalModifier(colorCode: 240)
        }
    }

    public var color: Color {
        #if !os(macOS)
        switch self {
        case .keyName: return UIColor.red
        case .keyValue: return UIColor.black
        case .punctuation: return UIColor.lightGray
        }

        #else

        switch self {
        case .keyName: return NSColor.systemOrange
        case .keyValue: return NSColor.labelColor
        case .punctuation: return NSColor.systemGray
        }
        #endif
    }

    // MARK: - Initialisation

    public init(from match: String) {
        switch match {
        case \.isPunctuation: self = .punctuation
        case \.isKeyName: self = .keyName
        default: self = .keyValue
        }
    }
}

private extension String {

    static let punctuationSet: Set<String> = ["]", "[", "(", ")", "{", "}", ","]

    var isPunctuation: Bool { Self.punctuationSet.contains(self) }
    var isKeyName: Bool { self.hasPrefix("\"") && self.hasSuffix(":") }
}
