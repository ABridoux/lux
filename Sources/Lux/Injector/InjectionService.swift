import Foundation

public struct InjectionService {

    /// Parse the given text with the given regular expression pattern, calling the injection closure parameter when a match is found to give the opportunity to modify it.
    /// - Parameters:
    ///   - text: The text to parse.
    ///   - pattern: A `RegexPattern` to use to build the regular expression which will find matches in the text.
    ///   - injectionClosure: Called by the service when a match is found by the regular expression.
    /// - Throws: If the regular expression cannot be built with the given `RegexPattern`
    /// - Returns: The modified text
    public static func inject(in text: String, following pattern: RegexPattern, using injectionClosure: (String) -> String) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern.stringValue, options: [])

        let nsText = text as NSString
        let textRange = NSRange(location: 0, length: nsText.length)
        let matches = regex.matches(in: text, options: [], range: textRange)

        var modifiedText = ""

        // append the gap between the text beginning and the first match
        guard let firstMatch = matches.first else { return text }
        let firstGap = NSRange(location: 0, length: firstMatch.range.lowerBound)

        if firstGap.length > 0 {
            let gapString = nsText[firstGap]
            let modifiedGapString = gapString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? String(gapString) : injectionClosure(gapString)
            modifiedText.append(modifiedGapString)
        }

        // browse all the matches
        for index in 0..<matches.count - 1 {
            let match = matches[index]
            let nextMatch = matches[index + 1]

            // get the modified match
            let matchString = nsText[match.range]
            let modifiedMatch = injectionClosure(matchString)

            modifiedText.append(modifiedMatch)

            // get the modified string between two matches
            let noMatchLength = nextMatch.range.lowerBound - match.range.upperBound
            let noMatchRange = NSRange(location: match.range.upperBound, length: noMatchLength)

            if noMatchRange.length > 0 {
                // if we have something between two matches, offer the opprtunity to inject a string in it
                let noMatchString = nsText[noMatchRange]

                let modifiedNoMatch = noMatchString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? String(noMatchString) : injectionClosure(noMatchString)

                modifiedText.append(modifiedNoMatch)
            }
        }

        // append the last match and no match
        guard let lastMatch = matches.last else { return text }

        let lastMatchString = injectionClosure(nsText[lastMatch.range])
        modifiedText.append(lastMatchString)

        let lastNoMatchLength = textRange.upperBound - lastMatch.range.upperBound

        if lastNoMatchLength == 0 {
            // nothing is left
            return modifiedText
        }

        let range = NSRange(location: lastMatch.range.upperBound, length: lastNoMatchLength)
        let remainingString = nsText[range]

        let modifiedRemainingString = remainingString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? String(remainingString) : injectionClosure(remainingString)

        modifiedText.append(modifiedRemainingString)

        return modifiedText
    }

    /// Inject the given string in the text. The insertion method depends on the category and the text type
    /// - Parameters:
    ///   - stringtoInject: The string to inject (Css class, terminal color code...)
    ///   - type: The text type: Html or plain
    ///   - text: The text in which to insert the string
    /// - Returns: the modified match with the inserted string
    static public func inject(_ stringtoInject: String, in type: TextType, _ text: String) -> String {
        switch type {
        case .plain:
            return stringtoInject + text + TerminalColor.reset
        case .html:
            return #"<span class="\#(stringtoInject)">\#(text)</span>"#
        }
    }
}
