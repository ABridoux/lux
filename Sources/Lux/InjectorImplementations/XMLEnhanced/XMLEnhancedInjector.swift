import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLEnhancedInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<XMLEnhancedCategory, Output, Injection, InjType> {

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: InjType, delegate: Delegate = XMLEnhancedDelegate(), languageName: String = "json") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
