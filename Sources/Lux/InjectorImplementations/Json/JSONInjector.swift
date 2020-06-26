import Foundation

public final class JSONInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>:
    BaseInjector<JSONCategory, Output, Injection, InjType> {

    override var plainRegexPattern: RegexPattern { .json }
    override var htmlRegexPattern: RegexPattern { .json }

    override public init(type: InjType, delegate: Delegate = JSONDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
