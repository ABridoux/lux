import Foundation

open class ZshDelegate: InjectorDelegate<ZshCategory> {

    // MARK: - Functions

    // MARK: InjectorDelegate override

    public override func inject<Output, Injection>(_ category: ZshCategory, in injectorType: InjectorType<Output, Injection>, _ match: String) -> Output where Output: Appendable, Injection: InjectionType {

        let injection = self.injection(for: category, in: injectorType)

        switch category {

        case .program: return inject(injection, in: injectorType, program: match)

        case .string, .commandOrOptionValue: return inject(injection, in: injectorType, stringVithVariables: match)

        case .variable: return inject(injection, in: injectorType, variable: match)

        default: return injectorType.inject(injection, in: match)
        }
    }

    // MARK: Injection helpers

    open func inject<Output: Appendable, Injection: InjectionType>(_ injection: Injection, in injectorType: InjectorType<Output, Injection>, program match: String) -> Output {
        let keyword = self.injection(for: .keyword, in: injectorType)
        let punctuation = self.injection(for: .punctuation, in: injectorType)
        let command = self.injection(for: .commandOrOptionValue, in: injectorType)

        var output = Output.empty

        guard !match.isEmpty else { return Output(match) }

        // colorise both sudo and the program name as programs
        if match.hasPrefix("sudo") {
            return injectorType.inject(injection, in: match)
        }

        var program = match

        // handle the prefixes if present
        if match.hasPrefix("$") {
            output += injectorType.inject(keyword, in: "$")
            program.removeFirst()
        }

        guard let prefix = program.first else { return Output(match) }

        if ["[", "(", "`"].contains(prefix) {
            output += injectorType.inject(injection, in: String(prefix))
            program.removeFirst()
        }

        if ["|"].contains(prefix) {
            output += injectorType.inject(punctuation, in: String(prefix))
            program.removeFirst()
        }

        guard !program.isEmpty else { return Output(match) }

        // avoid to take numbers only as programs
        if program.trimmingCharacters(in: .decimalDigits).isEmpty { // we have numbers only
            output += injectorType.inject(command, in: program)
        } else {
            output += injectorType.inject(injection, in: program)
        }

        return output
    }

    open func inject<Output: Appendable, Injection: InjectionType>(_ injection: Injection, in injectorType: InjectorType<Output, Injection>, stringVithVariables match: String) -> Output {
        let variableInjection = self.injection(for: .variable, in: injectorType)

        // indicates whether the string contains variables
        var didParse = false

        // look for variables in the string
        var injectedVariables = try? InjectionService.inject(Output.self, in: match, following: .zshVariables) { string in
            didParse = true

            if ZshCategory(from: string) == .variable {
                return injectorType.inject(variableInjection, in: string)
            } else {
                return injectorType.inject(injection, in: string)
            }
        }

        if !didParse {
            // no variables were found so no opportunity to set the color. We do it now
            injectedVariables = injectorType.inject(injection, in: match)
        }

        return injectedVariables ?? Output(match)
    }

    open func inject<Output: Appendable, Injection: InjectionType>(_ injection: Injection, in injectorType: InjectorType<Output, Injection>, variable match: String) -> Output {
        let keywordInjection = self.injection(for: .keyword, in: injectorType)

        // colorise "=" as a keyword
        if match.hasSuffix("=") {
            var variable = match
            variable.removeLast()

            var output = injectorType.inject(injection, in: variable)
            output += injectorType.inject(keywordInjection, in: "=")

            return output
        } else {
            return injectorType.inject(injection, in: match)
        }
    }
}
