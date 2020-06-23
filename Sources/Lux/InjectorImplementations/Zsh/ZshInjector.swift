import Foundation

public final class ZshInjector: BaseInjector<ZshCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["zsh", "lang-zsh", "language-zsh", "bash", "lang-bash", "language-bash"] }
    override var plainRegexPattern: RegexPattern { .plainZsh }
    override var htmlRegexPattern: RegexPattern { .plainZsh }

    override public init(type: TextType, delegate: BaseInjector<ZshCategory>.Delegate = ZshDelegate()) {
        super.init(type: type, delegate: delegate)
    }
}
