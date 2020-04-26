import Foundation

public enum JsonCategory: Category {

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

    public var terminalColor: String {
        switch self {
        case .keyName: return "\u{001B}[38;5;197m"
        case .keyValue: return "\u{001B}[0;0m"
        case .punctuation: return "\u{001B}[38;5;240m"
        }
    }

    // MARK: - Initialisation

    init(from match: Substring) {
        switch match {
        case \.isPunctuation: self = .punctuation
        case \.isKeyName: self = .keyName
        default: self = .keyValue
        }
    }

    // MARK: - Functions

    public func inject(_ stringToInject: String, in type: TextType, _ text: Substring) -> String {
        switch type {
        case .plain: return plainTextInjection(in: text)
        case .html: return htmlTextInjection(in: text)
        }
    }

    func plainTextInjection(in text: Substring) -> String {
        switch self {
        case .punctuation: return terminalColor + text + Self.terminalResetColor
        case .keyValue:
            var modifiedText = " \(terminalColor)\(text.trimmingCharacters(in: .whitespacesAndNewlines))\(Self.terminalResetColor)"
            if text.hasSuffix("\n") { // inject the color before the new line
                modifiedText.append("\n")
            }
            return modifiedText
        case .keyName:
            return Self.punctuation.terminalColor + String(text[NSRange(location: 0, length: 1)]) // "
                + Self.keyName.terminalColor + String(text[NSRange(location: 1, length: text.count - 3)]) // string between brackets
                + Self.punctuation.terminalColor + String(text[NSRange(location: text.count - 2, length: 2)]) + Self.terminalResetColor // ":
        }
    }

    func htmlTextInjection(in text: Substring) -> String {
        switch self {
        case .punctuation: return #"<span class="\#(cssClass)">\#(text)</span>"#
        case .keyValue:
            var modifiedText = #" <span class="\#(cssClass)">\#(text.trimmingCharacters(in: .whitespacesAndNewlines))</span>"#
            if text.hasSuffix("\n") { // inject the color before the new line
                modifiedText.append("\n")
            }
            return modifiedText
        case .keyName:
            return #"<span class="\#(Self.punctuation.cssClass)">\#(text[NSRange(location: 0, length: 1)])</span>"# // "
                + #"<span class="\#(Self.keyName.cssClass)">\#(text[NSRange(location: 1, length: text.count - 3)])</span>"# // string between brackets
                + #"<span class="\#(Self.punctuation.cssClass)">\#(text[NSRange(location: text.count - 2, length: 2)])</span>"# // ":
        }
    }
}

private extension Substring {

    static let puntuationSet: Set<Substring> = ["]", "[", "(", ")", "{", "}", ","]

    var isPunctuation: Bool { Self.puntuationSet.contains(self) }
    var isKeyName: Bool { self.hasPrefix("\"") && self.hasSuffix("\":") }
}
