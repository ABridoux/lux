import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLEnhancedInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<XMLEnhancedCategory, Output, Injection, InjType> {

    // MARK: - Properties

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }
    public override var dataFormat: DataFormat { .xmlEnhanced }

    // MARK: - Initialisation

    override public init(type: InjType, delegate: Delegate = XMLEnhancedDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    // MARK: - Functions

    override func inject(_ category: XMLEnhancedCategory, in match: String) -> Output {
        switch category {

        case .openingTag(let tag), .closingTag(let tag):

            var openingBracket = type.textType.openingBracket
            let closingBracket = type.textType.closingBracket
            if case XMLEnhancedCategory.closingTag = category {
                openingBracket.append("/") // add the closing slash for closing tags
            }

            var injectedOutput = delegate.inject(.punctuation, in: type, openingBracket)
             injectedOutput += delegate.inject(category, in: type, tag)
             injectedOutput += delegate.inject(.punctuation, in: type, closingBracket)

            return injectedOutput

        default:
            return delegate.inject(category, in: type, match)
        }
    }
}
