import Foundation

public final class JSONInjector: BaseInjector<JSONCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["json", "lang-json", "language-json"] }
    override var plainRegexPattern: RegexPattern { .json }
    override var htmlRegexPattern: RegexPattern { .json }

    override public init(type: TextType, delegate: BaseInjector<JSONCategory>.Delegate = JSONDelegate()) {
        super.init(type: type, delegate: delegate)
    }
}
