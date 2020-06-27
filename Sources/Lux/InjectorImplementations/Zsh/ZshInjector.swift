import Foundation

public final class ZshInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<ZshCategory, Output, Injection, InjType> {

    // MARK: - Properties

    override var plainRegexPattern: RegexPattern { .plainZsh }
    override var htmlRegexPattern: RegexPattern { .plainZsh }

    // MARK: - Initialisation

    override public init(type: InjType, delegate: Delegate = ZshDelegate(), languageName: String = "zsh") {
        super.init(type: type, delegate: delegate, languageName: languageName)
        // add also bash as an accepted language name
        Self.lowercasedIdentifiers(for: "bash").forEach { languageIdentifiers.insert($0) }
    }

    // MARK: - Functions

    override func inject(_ category: ZshCategory, in match: String) -> Output {
        switch category {
        case .program: return injectIn(program: match)
        case .commandOrOptionValue, .string: return injectIn(category, commandOrStringWithVariables: match)
        case .variable: return injectIn(variable: match)
        default: return delegate.inject(category, in: type, match)
        }
    }

    // MARK: Injection helpers
    
    func injectIn(program: String) -> Output {

        var output = Output.empty

        guard !program.isEmpty else { return Output(program) }

        // colorise both sudo and the program name as programsprogram
        if program.hasPrefix("sudo") {
            return delegate.inject(.program, in: type, program)
        }

        var program = program // copy to work on the string

        // handle the prefixes if present
        if program.hasPrefix("$") {
            output += delegate.inject(.keyword, in: type, "$")
            program.removeFirst()
        }

        guard let prefix = program.first else { return Output(program) }

        if ["[", "(", "`"].contains(prefix) {
            output += delegate.inject(.punctuation, in: type, String(prefix))
            program.removeFirst()
        }

        if ["|"].contains(prefix) {
            output += delegate.inject(.keyword, in: type, String(prefix))
            program.removeFirst()
        }

        guard !program.isEmpty else { return Output(program) }

        // avoid to take numbers only as programs
        if program.trimmingCharacters(in: .decimalDigits).isEmpty { // we have numbers only
            output += delegate.inject(.commandOrOptionValue, in: type, program)
        } else {
            output += delegate.inject(.program, in: type, program)
        }

        return output
    }

    func injectIn(_ category: ZshCategory, commandOrStringWithVariables match: String) -> Output {
        // indicates whether the string contains variables
        var didParse = false

        // look for variables in the string
        var injectedVariables = try? InjectionService.inject(Output.self, in: match, following: .zshVariables) { string in
            didParse = true

            if ZshCategory(from: string) == .variable {
                return delegate.inject(.variable, in: type, string)
            } else {
                return delegate.inject(category, in: type, string)
            }
        }

        if !didParse {
            // no variables were found so no opportunity to set the color. We do it now
            injectedVariables = delegate.inject(category, in: type, match)
        }

        return injectedVariables ?? Output(match)
    }

    func injectIn(variable match: String) -> Output {

        // colorise "=" as a keyword
        if match.hasSuffix("=") {
            var variable = match
            variable.removeLast()

            var output = delegate.inject(.variable, in: type, variable)
            output += delegate.inject(.keyword, in: type, "=")

            return output
        } else {
            return delegate.inject(.variable, in: type, match)
        }
    }
}
