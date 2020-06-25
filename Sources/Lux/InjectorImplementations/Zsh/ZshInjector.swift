import Foundation

public final class ZshInjector<Output: Appendable, InjType: InjectorType<Output>>: BaseInjector<ZshCategory, Output, InjType> {

    override var plainRegexPattern: RegexPattern { .plainZsh }
    override var htmlRegexPattern: RegexPattern { .plainZsh }

    override public init(type: InjType, delegate: Delegate = ZshDelegate(), languageName: String = "zsh") {
        super.init(type: type, delegate: delegate, languageName: languageName)
        // add also bash as an accepted language name
        Self.lowercasedIdentifiers(for: "bash").forEach { languageIdentifiers.insert($0) }

    }
}
