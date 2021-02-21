import Foundation

extension RegexPattern {
    static let json = RegexPattern(#"\{|\}|\(|\)|\[|\]|,|"[^"]*"\s*:|"([^"]|\\")*[^\\]"|"""#, type: .plain)
}

public final class JSONInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<JSONCategory, Output, Injection, InjType> {

    // MARK: - Properties

    override var plainRegexPattern: RegexPattern { .json }
    override var htmlRegexPattern: RegexPattern { .json }
    public override var dataFormat: DataFormat { .zsh }

    // MARK: - Initialisation

    override public init(type: InjType, delegate: Delegate = JSONDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    // MARK: - Functions

    override func inject(_ category: JSONCategory, in match: String) -> Output {

        switch category {
        case .punctuation, .keyValue: return delegate.inject(category, in: type, match)
        case .keyName:

            guard let nameRange = NSRegularExpression.rangeOfQuotedString(in: match) else {
                assertionFailure("Error while parsing a key name: there are no quotes")
                return Output(match)
            }

            let firstQuoteRange = NSRange(location: 0, length: nameRange.lowerBound)
            let endRange = NSRange(location: nameRange.upperBound, length: match.nsRange.length - nameRange.upperBound)

            var output = delegate.inject(.punctuation, in: type, String(match[firstQuoteRange])) // " (first quotes)
            output += delegate.inject(.keyName, in: type, String(match[nameRange])) // string between brackets
            output += delegate.inject(.punctuation, in: type, String(match[endRange])) // ":

            return output
        }
    }
}
