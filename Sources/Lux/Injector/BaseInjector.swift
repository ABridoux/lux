import Foundation

open class BaseInjector<Cat: Category>: Injector {

    // MARK: - Constants

    public typealias Delegate = InjectorDelegate<Cat>

    // MARK: - Properties

    var type: TextType
    public var delegate: Delegate

    var defaultLanguageIdentifiers: Set<String> { [] }
    public var languageIdentifiers: Set<String> = []

    var plainRegexPattern: RegexPattern { .emptyPlain }
    var htmlRegexPattern: RegexPattern { .emptyHtml }

    var regexPattern: RegexPattern {
        switch type {
        case .plain: return plainRegexPattern
        case .html: return htmlRegexPattern
        }
    }

    // MARK: - Intialisation

    public init(type: TextType, delegate: Delegate) {
        self.type = type
        self.delegate = delegate
        languageIdentifiers = defaultLanguageIdentifiers
    }

    // MARK: - Functions

    open func inject(in text: String) -> String {
        let modifiedText = try? InjectionService.inject(String.self, in: text, following: regexPattern) { match in
            let category = Cat(from: match)

            return delegate.inject(category, in: type, match)
        }

        guard let finalText = modifiedText else {
            assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
            return text
        }

        return finalText
    }

    open func injectAttributed(in text: String) -> NSMutableAttributedString {
        let modifiedText = try? InjectionService.inject(AttributedString.self, in: text, following: regexPattern) { match in
            let category = Cat(from: match)

            return delegate.inject(category: category, match)
        }

        guard let finalText = modifiedText else {
            assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
            return NSMutableAttributedString(string: text)
        }

        return finalText.attrString
    }
}
