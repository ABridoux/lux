import Foundation

open class ZshDelegate: InjectorDelegate<ZshCategory> {

    // MARK: - Functions

    // MARK: InjectorDelegate overrides

    public override func inject(_ category: ZshCategory, in type: TextType, _ match: String) -> String {
        let stringToInject = injection(for: category, type: type)

        switch category {

        case .program: return inject(stringToInject, in: type, program: match)

        case .string, .commandOrOptionValue: return inject(stringToInject, in: type, stringVithVariables: match)

        case .variable: return inject(stringToInject, in: type, variable: match)

        default: return InjectionService.inject(stringToInject, in: type, match)
        }
    }

    // MARK: Injection helpers
    
    func inject(_ stringToInject: String, in type: TextType, program match: String) -> String {
        let keywordMark = injection(for: .keyword, type: type)
        let punctuationMark = injection(for: .punctuation, type: type)
        let commandMark = injection(for: .commandOrOptionValue, type: type)

        var injection = ""

        guard !match.isEmpty else { return match }

        if match.hasPrefix("sudo") {
            return InjectionService.inject(stringToInject, in: type, match)
        }

        var program = match

        if match.hasPrefix("$") {
            injection += InjectionService.inject(keywordMark, in: type, "$")
            program.removeFirst()
        }

        guard let prefix = program.first else { return match }

        if ["[", "(", "`"].contains(prefix) {
            injection += InjectionService.inject(punctuationMark, in: type, String(prefix))
            program.removeFirst()
        }

        if ["|"].contains(prefix) {
            injection += InjectionService.inject(keywordMark, in: type, String(prefix))
            program.removeFirst()
        }

        guard !program.isEmpty else { return match }
        if program.trimmingCharacters(in: .decimalDigits).isEmpty { // we have numbers only
            injection += InjectionService.inject(commandMark, in: type, program)
        } else {
            injection += InjectionService.inject(stringToInject, in: type, program)
        }

        return injection
    }

    func inject(_ stringToInject: String, in type: TextType, stringVithVariables match: String) -> String {
        let variableMark = injection(for: .variable, type: type)

        let injectedVariables = try? InjectionService.inject(String.self, in: match, following: .zshVariables) { string in
            if ZshCategory(from: string) == .variable {
                return InjectionService.inject(variableMark, in: type, string)
            } else {
                return InjectionService.inject(stringToInject, in: type, string)
            }
        }

        let stringWithVariables = injectedVariables ?? match
        return InjectionService.inject(stringToInject, in: type, stringWithVariables)
    }

    func inject(_ stringToInject: String, in type: TextType, variable match: String) -> String {
        let keywordMark = injection(for: .keyword, type: type)

        if match.hasSuffix("=") {
            var variable = match
            variable.removeLast()

            var injection = InjectionService.inject(stringToInject, in: type, variable)
            injection += InjectionService.inject(keywordMark, in: type, "=")

            return injection
        } else {
            return InjectionService.inject(stringToInject, in: type, match)
        }
    }
}
