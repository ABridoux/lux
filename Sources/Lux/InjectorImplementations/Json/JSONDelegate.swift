import Foundation

open class JSONDelegate: InjectorDelegate<JSONCategory> {

    public override func inject(_ category: JSONCategory, in type: TextType, _ match: String) -> String {
        let stringToInject = injection(for: category, type: type)
        let matchCount = match.count

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
            var injection = InjectionService.inject(punctuationMark, in: type, String(match[NSRange(location: 0, length: 1)])) // "
            injection += InjectionService.inject(keyNameMark, in: type, String(match[NSRange(location: 1, length: matchCount - 3)])) // string between brackets
            injection += InjectionService.inject(punctuationMark, in: type, String(match[NSRange(location: matchCount - 2, length: 2)])) // ":

            return injection
        }
    }

    public override func inject(category: JSONCategory, _ match: String) -> AttributedString {
        let color = self.color(for: category)
        let matchCount = match.count

        switch category {
        case .punctuation, .keyValue:
            var attrString = AttributedString(match)
            attrString.textColor = color
            return attrString

        case .keyName:
            var openingQuote = AttributedString(match[NSRange(location: 0, length: 1)]) // "
            openingQuote.textColor = self.color(for: .punctuation)
            var keyName = AttributedString(match[NSRange(location: 1, length: matchCount - 3)]) // string between brackets
            keyName.textColor = self.color(for: .keyName)
            var closingQuote = AttributedString(match[NSRange(location: matchCount - 2, length: 2)]) // ":
            closingQuote.textColor = self.color(for: .punctuation)

            let injection = openingQuote
            injection.append(keyName)
            injection.append(closingQuote)

            return injection
        }
    }
}
