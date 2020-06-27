import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json, zsh, swift

    func injector<Injection: InjectionType>(injectorType: InjectorType<String, Injection>, escapingHTML: Bool = false) -> TextInjector {
        // Not possible to store a type to reuse it in generics
        // https://stackoverflow.com/questions/30905060/using-a-type-variable-in-a-generic
        var injector: TextInjector

        switch self {
        case .xml:
            if injectorType is Html {
                injector = XMLEnhancedInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                injector = XMLEnhancedInjector(type: .html)
            }
        case .plist:
            if injectorType is Html {
                injector = PlistInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                injector = PlistInjector(type: .html)
            }
        case .json:
            if injectorType is Html {
                injector = JSONInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                injector = JSONInjector(type: .html)
            }
        case .zsh:
            if injectorType is Html {
                injector = ZshInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                injector = ZshInjector(type: .html)
            }
        case .swift:
            if injectorType is Html {
                injector = SwiftInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                injector = SwiftInjector(type: .html)
            }
        }

        return injector
    }
}
