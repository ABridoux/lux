import Foundation

/// A wrapper around `String` to store regular expression patterns more robustly.
public struct RegexPattern {

    // MARK: - Constants

    public static var emptyPlain: RegexPattern { .init((""), type: .plain) }
    public static var emptyHtml: RegexPattern { .init((""), type: .html) }

    // MARK: - Properties

    public let stringValue: String
    public var type: TextType

    // MARK: - Initialisation

    public init(_ pattern: String, type: TextType) {
        stringValue = pattern
        self.type = type
    }
}
