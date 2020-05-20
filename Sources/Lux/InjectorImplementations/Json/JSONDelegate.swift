import Foundation

open class JSONDelegate: InjectorDelegate<JSONCategory> {

    public override func inject(_ category: JSONCategory, in type: TextType, _ match: String) -> String {
        let stringToInject = injection(for: category, type: type)

        let punctuationMark = injection(for: .punctuation, type: type)
        let keyNameMark = injection(for: .keyName, type: type)

        switch category {
        case .punctuation:
            return InjectionService.inject(punctuationMark, in: type, match)

        case .keyValue:
            var modifiedText = ""

            if match.hasPrefix(" ") { // inject the color after the white space
                modifiedText.append(" ")
            }

            modifiedText += InjectionService.inject(stringToInject, in: type, match.trimmingCharacters(in: .whitespacesAndNewlines))

            if match.hasSuffix("\n") { // inject the color before the new line
                modifiedText.append("\n")
            }
            return modifiedText

        case .keyName:

            guard let nameRange = NSRegularExpression.rangeOfQuotedString(in: match) else {
                assertionFailure("Error while parsing a key name: there is no quotes")
                return match
            }

            let firstQuoteRange = NSRange(location: 0, length: nameRange.lowerBound)
            let endRange = NSRange(location: nameRange.upperBound, length: (match as NSString).length - nameRange.upperBound)

            var injection = InjectionService.inject(punctuationMark, in: type, String(match[firstQuoteRange])) // "
            injection += InjectionService.inject(keyNameMark, in: type, String(match[nameRange])) // string between brackets
            injection += InjectionService.inject(punctuationMark, in: type, String(match[endRange])) // ":

            return injection
        }
    }

    public override func inject(category: JSONCategory, _ match: String) -> AttributedString {
        let color = self.color(for: category)

        switch category {
        case .punctuation, .keyValue:
            var attrString = AttributedString(match)
            attrString.textColor = color
            return attrString

        case .keyName:

            guard let nameRange = NSRegularExpression.rangeOfQuotedString(in: match) else {
                assertionFailure("Error while parsing a key name: there is no quotes")
                return AttributedString(match)
            }

            let firstQuoteRange = NSRange(location: 0, length: nameRange.lowerBound)
            let endRange = NSRange(location: nameRange.upperBound, length: (match as NSString).length - nameRange.upperBound)

            var openingQuote = AttributedString(match[firstQuoteRange]) // "
            openingQuote.textColor = self.color(for: .punctuation)
            var keyName = AttributedString(match[nameRange]) // string between brackets
            keyName.textColor = self.color(for: .keyName)
            var closingQuote = AttributedString(match[endRange]) // ":
            closingQuote.textColor = self.color(for: .punctuation)

            let injection = openingQuote
            injection.append(keyName)
            injection.append(closingQuote)

            return injection
        }
    }
}
