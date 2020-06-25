import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLInjector<Output: Appendable, InjType: InjectorType<Output>>: BaseInjector<XMLCategory, Output, InjType> {

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: InjType, delegate: Delegate = XMLDelegate(), languageName: String = "xml") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
