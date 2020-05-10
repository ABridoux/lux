import Foundation
#if !os(macOS)
import UIKit
#else
import AppKit
#endif

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

    public var terminalColor: String {
        switch self {
        case .keyName: return "\u{001B}[38;5;197m"
        case .keyValue: return "\u{001B}[0;0m"
        case .punctuation: return "\u{001B}[38;5;240m"
        }
    }

    public var color: Color {
        #if !os(macOS)
        switch self {
        case .keyName: return UIColor.red
        case .keyValue: return UIColor.black
        case .punctuation: return UIColor.lightgray
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

    init(from match: String) {
        switch match {
        case \.isPunctuation: self = .punctuation
        case \.isKeyName: self = .keyName
        default: self = .keyValue
        }
    }

    // MARK: - Functions

    public func inject(in type: TextType, _ text: String) -> String {
        switch type {
        case .plain: return plainTextInjection(in: text)
        case .html: return htmlTextInjection(in: text)
        }
    }

    func plainTextInjection(in text: String) -> String {
        switch self {
        case .punctuation: return terminalColor + text + Colors.terminalReset
        case .keyValue:
            var modifiedText = ""
            if text.hasPrefix(" ") { // inject the color after the white space
                modifiedText.append(" ")
            }
            modifiedText += "\(terminalColor)\(text.trimmingCharacters(in: .whitespacesAndNewlines))\(Colors.terminalReset)"
            if text.hasSuffix("\n") { // inject the color before the new line
                modifiedText.append("\n")
            }
            return modifiedText
        case .keyName:
            var injection = Self.punctuation.terminalColor + String(text[NSRange(location: 0, length: 1)]) // "
            injection += Self.keyName.terminalColor + String(text[NSRange(location: 1, length: text.count - 3)]) // string between brackets
            injection += Self.punctuation.terminalColor + String(text[NSRange(location: text.count - 2, length: 2)]) + Colors.terminalReset // ":

            return injection
        }
    }

    func htmlTextInjection(in text: String) -> String {
        switch self {
        case .punctuation: return #"<span class="\#(cssClass)">\#(text)</span>"#
        case .keyValue:
            var modifiedText = ""
            if text.hasPrefix(" ") { // inject the color after the white space
                modifiedText.append(" ")
            }
            modifiedText += #"<span class="\#(cssClass)">\#(text.trimmingCharacters(in: .whitespacesAndNewlines))</span>"#
            if text.hasSuffix("\n") { // inject the color before the new line
                modifiedText.append("\n")
            }

            return modifiedText
        case .keyName:
            var injection =  #"<span class="\#(Self.punctuation.cssClass)">\#(text[NSRange(location: 0, length: 1)])</span>"# // "
            injection +=  #"<span class="\#(Self.keyName.cssClass)">\#(text[NSRange(location: 1, length: text.count - 3)])</span>"# // string between brackets
            injection +=  #"<span class="\#(Self.punctuation.cssClass)">\#(text[NSRange(location: text.count - 2, length: 2)])</span>"# // ":

            return injection
        }
    }

    public func injectAttributed(in text: String) -> AttributedString {
        switch self {
        case .punctuation, .keyValue:
            var attrString = AttributedString(text)
            attrString.textColor = color
            return attrString
        case .keyName:
            var openingQuote = AttributedString(text[NSRange(location: 0, length: 1)])
            openingQuote.textColor = Self.punctuation.color
            var stringBetweenBrackets = AttributedString(text[NSRange(location: 1, length: text.count - 3)])
            stringBetweenBrackets.textColor = Self.keyName.color
            var closingQuote = AttributedString(text[NSRange(location: text.count - 2, length: 2)])
            closingQuote.textColor = Self.punctuation.color

            let attrString = AttributedString()
            attrString.append(openingQuote)
            attrString.append(stringBetweenBrackets)
            attrString.append(closingQuote)

            return attrString
        }
    }
}

private extension String {

    static let punctuationSet: Set<String> = ["]", "[", "(", ")", "{", "}", ","]

    var isPunctuation: Bool { Self.punctuationSet.contains(self) }
    var isKeyName: Bool { self.hasPrefix("\"") && self.hasSuffix("\":") }
}
