import Foundation

struct InjectionService {

    /// Parse the given text with the given regular expression pattern, calling the injection closure parameter when a match is found to give the opportunity to modify it.
    /// - Parameters:
    ///   - text: The text to parse.
    ///   - pattern: A `RegexPattern` to use to build the regular expression which will find matches in the text.
    ///   - injectionClosure: Called by the service when a match is found by the regular expression.
    /// - Throws: If the regular expression cannot be built with the given `RegexPattern`
    /// - Returns: The modified text
    static func inject<StringType: Appendable>(_ type: StringType.Type, in text: String, following pattern: RegexPattern, using injectionClosure: (String) -> StringType) throws -> StringType {
        let regex = try NSRegularExpression(pattern: pattern.stringValue, options: [])

        let nsText = text as NSString
        let textRange = NSRange(location: 0, length: nsText.length)
        let matches = regex.matches(in: text, options: [], range: textRange)

        var modifiedText = StringType.empty

        // append the gap between the text beginning and the first match
        guard let firstMatch = matches.first else { return StringType(text) }
        let firstGap = NSRange(location: 0, length: firstMatch.range.lowerBound)

        if firstGap.length > 0 {
            let gapString = nsText[firstGap]
            let modifiedGapString = gapString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? StringType(gapString) : injectionClosure(gapString)
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

                let modifiedNoMatch = noMatchString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? StringType(noMatchString) : injectionClosure(noMatchString)

                modifiedText.append(modifiedNoMatch)
            }
        }

        // append the last match and no match
        guard let lastMatch = matches.last else { return StringType(text) }

        let lastMatchString = injectionClosure(nsText[lastMatch.range])
        modifiedText.append(lastMatchString)

        let lastNoMatchLength = textRange.upperBound - lastMatch.range.upperBound

        if lastNoMatchLength == 0 {
            // nothing is left
            return modifiedText
        }

        let range = NSRange(location: lastMatch.range.upperBound, length: lastNoMatchLength)
        let remainingString = nsText[range]

        let modifiedRemainingString = remainingString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? StringType(remainingString) : injectionClosure(remainingString)

        modifiedText.append(modifiedRemainingString)

        return modifiedText
    }

    /// Inject the given string in the text. The insertion method depends on the category and the text type
    /// - Parameters:
    ///   - stringToInject: The string to inject (Css class, terminal color code...)
    ///   - type: The text type: Html or plain
    ///   - text: The text in which to insert the string
    /// - Returns: the modified match with the inserted string
    static func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String {

        let textCount = text.nsRange.upperBound

        // try to get the range of the trimmed (white spaces and newlines) string
        guard let trimmedRange = NSRegularExpression.trimmedWhiteSpacesAndNewLinesRange(in: text),
            trimmedRange.lowerBound > 0 || trimmedRange.upperBound < textCount
        else { // no trimming was needed
            switch type {
            case .plain:
                return stringToInject + text + TerminalModifier.resetColors.raw
            case .html:
                return #"<span class="\#(stringToInject)">\#(text)</span>"#
            }
        }

        // isolate left and right ranges to inject the string only in the trimmed string
        var match = (text as NSString)[trimmedRange]

        switch type {
        case .plain:
            match = stringToInject + match + TerminalModifier.resetColors.raw
        case .html:
            match = #"<span class="\#(stringToInject)">\#(match)</span>"#
        }

        var injectedText = ""

        if trimmedRange.lowerBound > 0 {
            let leftRange = NSRange(location: 0, length: trimmedRange.lowerBound)
            injectedText += text[leftRange]
        }

        injectedText += match

        if trimmedRange.upperBound <  textCount {
            let rightRange = NSRange(location: trimmedRange.upperBound, length: textCount - trimmedRange.upperBound)
            injectedText += text[rightRange]
        }

        return injectedText
    }
}
