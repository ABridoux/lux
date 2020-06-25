import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json, zsh, swift

    func injector(type: TextType) -> PlainTextInjector {
        switch self {
        case .xml: return XMLEnhancedInjector(type: .terminal)
        case .plist: return PlistInjector(type: .terminal)
        case .json: return JSONInjector(type: .terminal)
        case .zsh: return ZshInjector(type: .terminal)
        case .swift: return SwiftInjector(type: .terminal)
        }
    }
}
