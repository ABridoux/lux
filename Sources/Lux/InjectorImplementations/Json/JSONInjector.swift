import Foundation

public final class JSONInjector: BaseInjector<JSONCategory> {

    override var plainRegexPattern: RegexPattern { .json }
    override var htmlRegexPattern: RegexPattern { .json }

    override public init(type: TextType, delegate: BaseInjector<JSONCategory>.Delegate = JSONDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
