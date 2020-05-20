import Foundation

/// Inject colors as string (e.g. html tag or terminal color) or as attributes (for attributed string) inside a text depending on the categories
/// of the found matches, and output the result.
/// - note: The behavior can be customised by setting a custom delegate. This delegate can modify the color injected, or the way it is injected.
open class BaseInjector<Cat: Category>: Injector {

    // MARK: - Constants

    public typealias Delegate = InjectorDelegate<Cat>

    // MARK: - Properties

    /// Type of the text to parse
    var type: TextType

    public var delegate: Delegate

    /// Set of already know language identifiers, used as a base
    var defaultLanguageIdentifiers: Set<String> { [] }
    public var languageIdentifiers: Set<String> = []

    /// RegexPattern used when the type of the parsed text is `plain`
    var plainRegexPattern: RegexPattern { .emptyPlain }

    /// RegexPattern used when the type of the parsed text is `html`
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

        return finalText.nsAttributedString
    }
}
