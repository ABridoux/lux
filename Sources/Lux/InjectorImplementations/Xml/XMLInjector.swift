import Foundation

// MARK: Regex

extension RegexPattern {
    static let htmlXml = RegexPattern(#"&lt;("[^"]*"|'[^']*'|[^&]*)+&gt;"#, type: .html)
    static let plainXml = RegexPattern(#"<("[^"]*"|'[^']*'|[^<^>])+>"#, type: .plain)
}

// MARK: Delegate

public typealias XMLDelegate = InjectorDelegate<XMLCategory>

// MARK: - Injector

/// Inject strings into a text depending on the configuration or the delegate.
public final class XMLInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<XMLCategory, Output, Injection, InjType> {

    // MARK: - Properties

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    // MARK: - Initialisation

    override public init(type: InjType, delegate: Delegate = XMLDelegate(), languageName: String = "xml") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }
}
