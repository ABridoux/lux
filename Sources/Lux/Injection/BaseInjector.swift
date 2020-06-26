import Foundation

/// Inject colors as string (e.g. html tag or terminal color) or as attributes (for attributed string) inside a text depending on the categories
/// of the found matches, and output the result.
/// - note: The behavior can be customised by setting a custom delegate. This delegate can modify the color injected, or the way it is injected.
open class BaseInjector<Cat: Category, Output: Appendable, Injection: InjectionType, Injector: InjectorType<Output, Injection>> {

    // MARK: - Constants

    public typealias Delegate = InjectorDelegate<Cat>

    // MARK: - Properties

    /// Type of the text to parse
    var textType: TextType
    var type: Injector

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

    public init(type: Injector, delegate: Delegate, languageName: String) {
        self.type = type
        textType = type.textType
        self.delegate = delegate
        defaultLanguageIdentifiers = Self.lowercasedIdentifiers(for: languageName)
        languageIdentifiers = defaultLanguageIdentifiers
    }

    // MARK: - Functions

    static func lowercasedIdentifiers(for language: String) -> Set<String> { [language, "lang-\(language)", "language-\(language)"] }

    /// Inject modifiers to colorise an input String.
    /// - Parameter text: The text to colorise
    /// - Returns: The colorised text. The output type will depend of the Injector type you use: HTML String, Terminal: String, App: AttributedString. You can retrieve the `NSMutableString` value
    /// from an `AttributedString` with the `nsAttributedString` property.
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

    /// Called to know how to inject a color mark in a match of a give category
    func inject(_ category: Cat, in match: String) -> Output { delegate.inject(category, in: type, match) }
}
