import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json, zsh, swift

    func injector<Injection: InjectionType>(injectorType: InjectorType<String, Injection>, theme: ColorTheme? = nil, escapingHTML: Bool = false) -> TextInjector {
        // Not possible to store a type to reuse it in generics
        // https://stackoverflow.com/questions/30905060/using-a-type-variable-in-a-generic
        var injector: TextInjector

        switch self {
        case .xml:
            if injectorType is Html {
                injector = XMLEnhancedInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                var delegate = XMLEnhancedDelegate()
                if let theme = theme {
                    delegate = XMLEnhancedDelegate.theme(theme)
                }
                injector = XMLEnhancedInjector(type: .terminal, delegate: delegate)
            }

        case .plist:
            if injectorType is Html {
                injector = PlistInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                var delegate = PlistDelegate()
                if let theme = theme {
                    delegate = .theme(theme)
                }
                injector = PlistInjector(type: .terminal, delegate: delegate)
            }

        case .json:
            if injectorType is Html {
                injector = JSONInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                var delegate = JSONDelegate()
                if let theme = theme {
                    delegate = .theme(theme)
                }
                injector = JSONInjector(type: .terminal, delegate: delegate)
            }

        case .zsh:
            if injectorType is Html {
                injector = ZshInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                var delegate = ZshDelegate()
                if let theme = theme {
                    delegate = .theme(theme)
                }
                injector = ZshInjector(type: .terminal, delegate: delegate)
            }

        case .swift:
            if injectorType is Html {
                injector = SwiftInjector(type: .html).escapingHTML(escapingHTML)
            } else {
                var delegate = SwiftDelegate()
                if let theme = theme {
                    delegate = .theme(theme)
                }
                injector = SwiftInjector(type: .terminal, delegate: delegate)
            }
        }

        return injector
    }
}
