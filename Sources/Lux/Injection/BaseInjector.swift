import Foundation

/// Inject colors as string (e.g. html tag or terminal color) or as attributes (for attributed string) inside a text depending on the categories
/// of the found matches, and output the result.
/// - note: The behavior can be customised by setting a custom delegate. This delegate can modify the color injected, or the way it is injected.
open class BaseInjector<Cat: Category, Output: Appendable, InjType: InjectorType<Output>> {

    // MARK: - Constants

    public typealias Delegate = InjectorDelegate<Cat>

    // MARK: - Properties

    /// Type of the text to parse
    var textType: TextType
    var type: InjType

    public var delegate: Delegate

    /// Set of already know language identifiers, used as a base
    var defaultLanguageIdentifiers: Set<String>
    public var languageIdentifiers: Set<String> = []

    /// RegexPattern used when the type of the parsed text is `plain`
    var plainRegexPattern: RegexPattern { .emptyPlain }

    /// RegexPattern used when the type of the parsed text is `html`
    var htmlRegexPattern: RegexPattern { .emptyHtml }

    var regexPattern: RegexPattern {
        switch textType {
        case .plain: return plainRegexPattern
        case .html: return htmlRegexPattern
        }
    }

    // MARK: - Intialisation

//    public init(type: TextType, delegate: Delegate, languageName: String) {
//        self.type = type
//        self.delegate = delegate
//        defaultLanguageIdentifiers = Self.lowercasedIdentifiers(for: languageName)
//        languageIdentifiers = defaultLanguageIdentifiers
//    }

    public init(type: InjType, delegate: Delegate, languageName: String) {
        self.type = type
        textType = type.textType
        self.delegate = delegate
        defaultLanguageIdentifiers = Self.lowercasedIdentifiers(for: languageName)
        languageIdentifiers = defaultLanguageIdentifiers
    }

    // MARK: - Functions

    static func lowercasedIdentifiers(for language: String) -> Set<String> { [language, "lang-\(language)", "language-\(language)"] }

    open func inject(in text: String) -> Output {
        let modifiedInput = try? InjectionService.inject(Output.self, in: text, following: regexPattern) { match in
            let category = Cat(from: match)

            return inject(category, in: match)
        }

        guard let output = modifiedInput else {
            assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
            return Output(text)
        }

        return output
    }

    open func inject(_ category: Cat, in match: String) -> Output {

        switch type {

        case is Terminal, is Html: return Output(delegate.inject(category, in: type.textType, match))

        case is App: return Output(attributedString: AttributedString(match, color: delegate.color(for: category)))

        default:
            assertionFailure("\(Output.self) not handled")
            return Output("")
        }
    }
}
