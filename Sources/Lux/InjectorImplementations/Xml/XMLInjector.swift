import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLInjector: BaseInjector<XMLCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["xml", "lang-xml", "language-xml"] }
    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: TextType, delegate: BaseInjector<XMLCategory>.Delegate = XMLDelegate()) {
        super.init(type: type, delegate: delegate)
    }
}
