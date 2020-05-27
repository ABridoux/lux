import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLEnhancedInjector: BaseInjector<XMLEnhancedCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["xml", "lang-xml", "language-xml"] }
    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: TextType, delegate: BaseInjector<XMLEnhancedCategory>.Delegate = XMLEnhancedDelegate()) {
        super.init(type: type, delegate: delegate)
    }
}
