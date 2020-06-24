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

    public override func inject(category: ZshCategory, _ match: String) -> AttributedString {
        let color = self.color(for: category)

        switch category {

        case .program: return inject(color, program: match)

        case .string, .commandOrOptionValue: return inject(color, stringVithVariables: match)

        case .variable: return inject(color, variable: match)

        default: return AttributedString(match, color: color)
        }
    }

    // MARK: Injection helpers

    func inject(_ stringToInject: String, in type: TextType, program match: String) -> String {
        let keywordMark = injection(for: .keyword, type: type)
        let punctuationMark = injection(for: .punctuation, type: type)
        let commandMark = injection(for: .commandOrOptionValue, type: type)

        var injection = ""

        guard !match.isEmpty else { return match }

        // colorise both sudo and the program name as programs
        if match.hasPrefix("sudo") {
            return InjectionService.inject(stringToInject, in: type, match)
        }

        var program = match

        // handle the prefixes if present
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

        // avoid to take numbers only as programs
        if program.trimmingCharacters(in: .decimalDigits).isEmpty { // we have numbers only
            injection += InjectionService.inject(commandMark, in: type, program)
        } else {
            injection += InjectionService.inject(stringToInject, in: type, program)
        }

        return injection
    }

    func inject(_ color: Color, program match: String) -> AttributedString {
        let keywordColor = self.color(for: .keyword)
        let punctuationColor = self.color(for: .punctuation)
        let commandColor = self.color(for: .commandOrOptionValue)

        var attrString = AttributedString.empty

        guard !match.isEmpty else { return match.attributed }

        // colorise both sudo and the program name as programs
        if match.hasPrefix("sudo") {
            return AttributedString(match, color: color)
        }

        var program = match

        // handle the prefixes if present
        if match.hasPrefix("$") {
            attrString.append("$", with: keywordColor)
            program.removeFirst()
        }

        guard let prefix = program.first else { return match.attributed }

        if ["[", "(", "`"].contains(prefix) {
            attrString.append(String(prefix), with: punctuationColor)
            program.removeFirst()
        }

        if ["|"].contains(prefix) {
            attrString.append("|", with: keywordColor)
            program.removeFirst()
        }

        guard !program.isEmpty else { return match.attributed }

        // avoid to take numbers only as programs
        if program.trimmingCharacters(in: .decimalDigits).isEmpty { // we have numbers only
            attrString.append(program, with: commandColor)
        } else {
            attrString.append(program, with: color)
        }

        return attrString

    }

    func inject(_ stringToInject: String, in type: TextType, stringVithVariables match: String) -> String {
        let variableMark = injection(for: .variable, type: type)

        // look for variables in the string
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

    func inject(_ color: Color, stringVithVariables match: String) -> AttributedString {
        let variableColor = self.color(for: .variable)

        var attrString = AttributedString.empty
        attrString.textColor = color

        // indicates whether the string contains variables
        var didParse = false

        // look for variables in the string
        var injectedVariables = try? InjectionService.inject(AttributedString.self, in: match, following: .zshVariables) { string in
            didParse = true
            if ZshCategory(from: string) == .variable {
                return AttributedString(string, color: variableColor)
            } else {
                return AttributedString(string, color: color)
            }
        }

        if !didParse {
            // no variables were found so no opportunity to set the color. We do it now
            injectedVariables?.textColor = color
        }

        attrString.append(injectedVariables ?? AttributedString(match, color: color))

        return attrString
    }

    func inject(_ stringToInject: String, in type: TextType, variable match: String) -> String {
        let keywordMark = injection(for: .keyword, type: type)

        // colorise "=" as a keyword
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

    func inject(_ color: Color, variable match: String) -> AttributedString {
        let keywordColor = self.color(for: .keyword)

        // colorise "=" as a keyword
        if match.hasSuffix("=") {
            var variable = match
            variable.removeLast()

            var attrString = AttributedString(variable, color: color)
            attrString.append("=", with: keywordColor)

            return attrString
        } else {
            return AttributedString(match, color: color)
        }
    }
}
