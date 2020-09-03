#if os(iOS)
import UIKit
#elseif os(macOS)
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

    #if !os(Linux)
    public var color: Color {
        switch self {
        case .keyName: return .red
        case .keyValue: return .black
        case .punctuation: return .lightGray
        }
    }
    #endif

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
