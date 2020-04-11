import Foundation

public struct Injector {

    /// Parse the given text with the given regular expression pattern, calling the injection closure parameter when a match is found to give the opportunity to modify it.
    /// - Parameters:
    ///   - text: The text to parse.
    ///   - pattern: A `RegexPattern` to use to build the regular expression which will find matches in the text.
    ///   - injectionClosure: Called by the service when a match is found by the regular expression.
    /// - Throws: If the regular expression cannot be built with the given `RegexPattern`
    /// - Returns: The modified text
    public static func inject(in text: String, following pattern: RegexPattern, using injectionClosure: (Substring) -> String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern.stringValue, options: [])
        let textRange = text.nsRange
        let matches = regex.matches(in: text, options: [], range: textRange)

        guard let lastMatch = matches.last else { return text }

        var modifiedText = ""

        for index in 0..<matches.count - 1 {
            let match = matches[index]
            let nextMatch = matches[index + 1]

            // get the modified match
            let matchString = text[match.range]
            let modifiedMatch = injectionClosure(matchString)

            modifiedText.append(modifiedMatch)

            // get the modified string between two matches
            let noMatchLength = nextMatch.range.lowerBound - match.range.upperBound
            let noMatchRange = NSRange(location: match.range.upperBound, length: noMatchLength)

            let noMatchString = text[noMatchRange]

            let modifiedNoMatch = noMatchString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? String(noMatchString) : injectionClosure(noMatchString)

            modifiedText.append(modifiedNoMatch)
        }

        // append the last match and no match
        let lastMatchString = injectionClosure(text[lastMatch.range])
        modifiedText.append(lastMatchString)

        let lastNoMatchLength = textRange.upperBound - lastMatch.range.upperBound

        if lastNoMatchLength == 0 {
            // nothing is left
            return modifiedText
        }

        let range = NSRange(location: lastMatch.range.upperBound, length: lastNoMatchLength)
        let remainingString = text[range]

        let modifiedRemainingString = remainingString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? String(remainingString) : injectionClosure(remainingString)

        modifiedText.append(modifiedRemainingString)

        return modifiedText
    }
}
