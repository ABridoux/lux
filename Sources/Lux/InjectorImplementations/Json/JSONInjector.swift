import Foundation

public final class JSONInjector<Output: Appendable, InjType: InjectorType<Output>>: BaseInjector<JSONCategory, Output, InjType> {

    override var plainRegexPattern: RegexPattern { .json }
    override var htmlRegexPattern: RegexPattern { .json }

    override public init(type: InjType, delegate: Delegate = JSONDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
