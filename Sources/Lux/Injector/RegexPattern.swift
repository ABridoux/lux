import Foundation

/// A wrapper around `String` to store more robustly regular expression patterns
public struct RegexPattern {

    // MARK: - Properties

    public let stringValue: String
    public var type: TextType

    // MARK: - Initialisation

    public init(_ pattern: String, type: TextType) {
        self.stringValue = pattern
        self.type = type
    }
}
