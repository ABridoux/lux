import Foundation

open class JSONDelegate: InjectorDelegate<JSONCategory> {

    public override func inject<Output: Appendable, Injection: InjectionType>(_ category: JSONCategory, in injectorType: InjectorType<Output, Injection>, _ match: String) -> Output {

        let injection = self.injection(for: category, in: injectorType)
        let punctuation = self.injection(for: .punctuation, in: injectorType)
        let keyName = self.injection(for: .keyName, in: injectorType)

        switch category {
        case .punctuation, .keyValue: return injectorType.inject(injection, in: match)
        case .keyName:

            guard let nameRange = NSRegularExpression.rangeOfQuotedString(in: match) else {
                assertionFailure("Error while parsing a key name: there are no quotes")
                return Output(match)
            }

            let firstQuoteRange = NSRange(location: 0, length: nameRange.lowerBound)
            let endRange = NSRange(location: nameRange.upperBound, length: match.nsRange.length - nameRange.upperBound)

            var output = injectorType.inject(punctuation, in: String(match[firstQuoteRange])) // " (first quotes)
            output += injectorType.inject(keyName, in: String(match[nameRange])) // string between brackets
            output += injectorType.inject(punctuation, in: String(match[endRange])) // ":

            return output
        }
    }
}
